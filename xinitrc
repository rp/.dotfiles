if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

WALL=$HOME/.wall

xrdb -load $DOTFILES/xrdb.conf

xset +fp /usr/share/fonts/misc
xset fp rehash

#xli -onroot -fill $WALL

xsetroot -cursor_name left_ptr &
numlockx &

start-pulseaudio-x11 &
caffeine &
nm-applet &

# fix java using various h4x
wmname LG3D
export _JAVA_AWT_WM_NONREPARENTING=1
$DOTFILES/scripts/java_nonreparenting_wm_hack
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp,lcd'
export JAVA_FONTS=/usr/share/fonts/TTF
export IDEA_JDK=/usr/lib/jvm/intellij-jdk
export PYCHARM_JDK=/usr/lib/jvm/intellij-jdk

# gotta composit, yo
compton -cf -D1 -e 0.4 -o1 -r8 -l-12 -t-12 &

# xdg user-dirs
$DOTFILES/scripts/user-dirs

#autorandr --change

xset +dpms
xset dpms 0 0 300

# map capslock to left ctrl
$DOTFILES/scripts/nocaps.sh

sxhkd -c $DOTFILES/sxhkdrc &
exec bspwm -c $DOTFILES/bspwmrc

