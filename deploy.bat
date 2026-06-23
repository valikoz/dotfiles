@echo off
setlocal EnableDelayedExpansion

set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

if "%~1"=="" (
    echo Usage: %~nx0 ^<MANIFEST^>
    echo ERROR: no MANIFEST file is provided
    exit /b 1
)

call :deployManifest "%~1"
exit /b %ERRORLEVEL%

:symlinkFile
set "filename=%SCRIPT_DIR%\%~1"
set "destination=%USERPROFILE%\%~2\%~1"

for %%D in ("%destination%") do (
    if not exist "%%~dpD" mkdir "%%~dpD"
)

if exist "%destination%" (
    fsutil reparsepoint query "%destination%" >nul 2>&1
    if not errorlevel 1 (
        echo [WARNING] %filename% already symlinked
        exit /b 0
    )

    echo [ERROR] %destination% exists but it's not a symlink. Please fix that manually
    exit /b 1
)

mklink "%destination%" "%filename%" >nul
if errorlevel 1 exit /b 1

echo [OK] %filename% -^> %destination%
exit /b 0

:deployManifest
set "manifest=%SCRIPT_DIR%\%~1"

for /f "usebackq tokens=* delims=" %%L in ("%manifest%") do (
    set "row=%%L"

    if not "!row!"=="" (
        if not "!row:~0,1!"=="#" (

            for /f "tokens=1-3 delims=|" %%A in ("!row!") do (
                set "filename=%%A"
                set "operation=%%B"
                set "destination=%%C"

                if /i "!operation!"=="symlink" (
                    call :symlinkFile "!filename!" "!destination!"
                    if errorlevel 1 exit /b 1
                ) else (
                    echo [WARNING] Unknown operation !operation!. Skipping...
                )
            )
        )
    )
)

exit /b 0
