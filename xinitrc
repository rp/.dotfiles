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

xsetroot -cursor_name left_ptr &

xrdb -load ~/.dotfiles/Xresources

nm-applet &
xfce4-power-manager
#tint3 -c ~/.dotfiles/tint3rc &

wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=setting'
~/.dotfiles/scripts/java_nonreparenting_wm_hack.sh

compton -cCf -D2 -e 0.4 -o1 -r8 -l-12 -t-12 &

sxhkd -c ~/.dotfiles/sxhkdrc &
#exec bspwm
exec bspwm -c ~/.dotfiles/bspwmrc
