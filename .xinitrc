#!/bin/sh

prefix="/usr"
exec_prefix="${prefix}"
xrdb="xrdb"
xinitdir="/etc/X11/xinit"
xterm="xterm"
xmodmap="xmodmap"

userresources="$HOME/.Xresources"
usermodmap="$HOME/.Xmodmap"
sysresources="$xinitdir/.Xresources"
sysmodmap="$xinitdir/.Xmodmap"

# merge in defaults and keymaps

if [ -f "$sysresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        "$xrdb" -merge "$sysresources"
    else
        "$xrdb" -nocpp -merge "$sysresources"
    fi
fi

if [ -f "$sysmodmap" ]; then
    "$xmodmap" "$sysmodmap"
fi

if [ -f "$userresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        "$xrdb" -merge "$userresources"
    else
        "$xrdb" -nocpp -merge "$userresources"
    fi
fi

if [ -d "$xinitdir"/xinitrc.d ] ; then
	for f in "$xinitdir/xinitrc.d"/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# xrandr --output eDP-1 --brightness 0.5
xinput set-prop 'SYNA2393:00 06CB:7A13 Touchpad' 'Synaptics Two-Finger Scrolling' 1, 1
xinput set-prop 'SYNA2393:00 06CB:7A13 Touchpad' 'Synaptics Scrolling Distance' -30, 30
xinput set-prop 'SYNA2393:00 06CB:7A13 Mouse' 'libinput Accel Speed' 1.0
setxkbmap -layout us,ua -option grp:shifts_toggle,ctrl:nocaps,compose:ralt,terminate:ctrl_alt_bksp
# xset r rate 200 35

exec i3
