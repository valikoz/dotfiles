# MacPorts Installer addition on 2025-12-11_at_03:09:55: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# export PATH="$HOME/.cargo/bin:/usr/local/Cellar/python@3.11/3.11.7_1/bin/python3:$PATH"
export PATH="$PATH:/opt/local/bin"
export PATH="$PATH:$HOME/.bin:$HOME/.local/bin"
export PATH="$PATH:$HOME/.bin:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/node-v24.12.0-darwin-x64/bin"

eval "$(luarocks path --bin)"

# export MAGICK_HOME="$HOME/.local/ImageMagick-7.0.10/"
# export PATH="$MAGICK_HOME/bin:$PATH"
# export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"

export DYLD_LIBRARY_PATH="$HOME/.local/lib/"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'

export TYPST_PACKAGE_PATH="$HOME/.local/share/typst/packages"
export TYPST_PACKAGE_CACHE_PATH="$HOME/.cache/typst"

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home
# export JAVA_HOME="$HOME/opt/jdk-17.0.2.jdk/Contents/Home"

# Android SDK
# platform-tools - adb
# cmdline-tools - sdkmanager
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin/:$ANDROID_HOME/platform-tools
# export PATH=$PATH:$ANDROID_HOME/emulator/emulator
export REPO_OS_OVERRIDE="macosx"

# export SSLKEYLOGFILE="$HOME/docs/sslkeylogfile.log"

# Svelte stuff
# export LAUNCH_EDITOR=launch_editor_script
