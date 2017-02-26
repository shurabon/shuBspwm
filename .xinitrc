#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
eval `dbus-launch --sh-syntax --exit-with-session`
export DBUS_SESSION_BUS_ADDRESS
fi

bash ~/.wallpapers/wp_init.sh


xsetroot -cursor_name left_ptr &
xrdb merge .Xresources &
compton -b &
#feh --bg-scale ~/image.jpg
devmon &
i3lock-wait-for-suspend &
setxkbmap "us,ru" ",winkeys" "grp:caps_toggle" &


 
sxhkd &
bspwm
