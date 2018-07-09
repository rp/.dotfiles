[ -r $HOME/.profile ] && emulate sh -c '. $HOME/.profile'

if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
    exec startx
fi

