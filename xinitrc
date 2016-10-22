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

xset +fp /usr/share/fonts/misc
xset fp rehash

xsetroot -cursor_name left_ptr &
numlockx &
#hsetroot -fill ~/wall

xrdb -load ~/.dotfiles/Xresources

nm-applet &
pnmixer &
xfce4-panel --disable-wm-check &

# fix java
wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1
~/.dotfiles/scripts/java_nonreparenting_wm_hack
_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp,lcd'

compton -cf -D2 -e 0.4 -o1 -r8 -l-12 -t-12 &

sxhkd -c ~/.dotfiles/sxhkdrc &
exec bspwm -c ~/.dotfiles/bspwmrc
