#!/bin/sh

pkill -x polybar

MONITOR=eDP1 polybar --config=$DOTFILES/polybar.conf main &
MONITOR=DP1-1 polybar --config=$DOTFILES/polybar.conf main &
MONITOR=DP1-2 polybar --config=$DOTFILES/polybar.conf aux &

