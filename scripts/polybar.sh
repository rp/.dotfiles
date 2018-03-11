#!/bin/sh

pkill -x polybar

MONITOR=eDP1 polybar --config=$HOME/.dotfiles/polybar.conf main &
MONITOR=DP1-1 polybar --config=$HOME/.dotfiles/polybar.conf main &
MONITOR=DP1-2 polybar --config=$HOME/.dotfiles/polybar.conf aux &
