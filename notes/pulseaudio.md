Pulse Audio
===========
Install Pulse Audio
```
$ sudo pacman -S pulseaudio pavucontrol
```

Sometimes there's a bug with `polybar` muting getting sound permanently muted.
I've seen this on my XPS 13, but didn't see it on my Matebook X Pro. If this
bug does happened, a
[fix](https://wiki.manjaro.org/index.php?title=Volume_Stuck_on_Mute_(XFCE_Desktop))
is to open `/etc/asound.conf` and enter _exactly_

```
pcm.pulse {
   type pulse
}
ctl.pulse {
   type pulse
}
pcm.!default {
   type pulse
}
ctl.!default {
   type pulse
}
```

