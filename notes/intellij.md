IntelliJ
========

Install IntelliJ:

```
$ sudo pacman -S intellij-idea-community-edition
```

and the JetBrains Runtime Environment:

```
$ yay -S intellij-jdk
```

To get IntelliJ to use the JetBrains Runtime Environment, start IntelliJ and
[hit Ctrl + Shift + A and search "Boot JDK" and select
`intellij-jdk`](https://intellij-support.jetbrains.com/hc/en-us/articles/206544879-Selecting-the-JDK-version-the-IDE-will-run-under).
Sometimes it seems that that doesn't actually work. If that's the case, a
[workaround](https://stackoverflow.com/questions/38452701/how-to-run-intellij-idea-with-jetbrains-runtime)
is to set `IDEA_JDK` to `intellij-jdk`.


For ligatures (specifically for Fira Mono), follow
[this](https://github.com/tonsky/FiraCode/wiki/Intellij-products-instructions).

