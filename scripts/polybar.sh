#!/bin/sh

pkill -x polybar

MONITOR=eDP1 polybar main &
MONITOR=DP1-1 polybar main &
MONITOR=DP1-2 polybar aux &
