if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xset +fp /usr/share/fonts/misc
xset fp rehash

hsetroot -fill ~/.wall

xsetroot -cursor_name left_ptr &
numlockx &

xrdb -load ~/.dotfiles/Xresources

start-pulseaudio-x11 &

caffeine &

# fix java
wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1
~/.dotfiles/scripts/java_nonreparenting_wm_hack
_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp,lcd'

compton -cf -D2 -e 0.4 -o1 -r8 -l-12 -t-12 &

# xdg user-dirs
~/.dotfiles/scripts/user-dirs

autorandr --change

xset +dpms
xset dpms 0 0 300

# map capslock to left ctrl
~/.dotfiles/scripts/nocaps.sh

sxhkd -c ~/.dotfiles/sxhkdrc &
exec bspwm -c ~/.dotfiles/bspwmrc
