if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

DOTFILES=$HOME/.dotfiles
WALL=$HOME/.wall

xset +fp /usr/share/fonts/misc
xset fp rehash

xli -onroot -fit $WALL

xsetroot -cursor_name left_ptr &
numlockx &

xrdb -load $DOTFILES/xrdb.conf

start-pulseaudio-x11 &
caffeine &

# fix java using various h4x
wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1
~/.dotfiles/scripts/java_nonreparenting_wm_hack
_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp,lcd'

# gotta composit, yo
compton -cf -D2 -e 0.4 -o1 -r8 -l-12 -t-12 &

# xdg user-dirs
~/.dotfiles/scripts/user-dirs

autorandr --change

xset +dpms
xset dpms 0 0 300

# map capslock to left ctrl
$DOTFILES/scripts/nocaps.sh

sxhkd -c $DOTFILES/sxhkdrc &
exec bspwm -c $DOTFILES/bspwmrc
