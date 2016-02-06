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

cd $HOME
source $HOME/.profile
export LANG="en_US.UTF-8"
exec >>~/.xsession-errors 2>&1

xsetroot -cursor_name left_ptr &

xrdb -load ~/.dotfiles/Xresources

sxhkd -c $HOME/.dotfiles/sxhkdrc &
urxvt &
#exec quartz-wm
exec bspwm -c $HOME/.dotfiles/bspwmrc
