#!/bin/sh

# Generates zathura configuration file
# FIXME make it actually use terminal colors

get_xres() {
    xrdb -query | grep $1 | awk '{print $2}'
}

cat <<CONF
set completion-bg "$(get_xres background:)"
set completion-fg "$(get_xres foreground:)"
set completion-group-bg "$(get_xres background:)"
set completion-group-fg "$color2"
set completion-highlight-bg "$(get_xres foreground:)"
set completion-highlight-fg "$(get_xres background:)"
set default-bg "$(get_xres background:)"
set default-fg "$(get_xres foreground:)"
set inputbar-bg "$(get_xres background:)"
set inputbar-fg "$(get_xres foreground:)"
set notification-bg "$(get_xres background:)"
set notification-fg "$(get_xres foreground:)"
set notification-error-bg "$color1"
set notification-error-fg "$(get_xres foreground:)"
set notification-warning-bg "$color1"
set notification-warning-fg "$(get_xres foreground:)"
set statusbar-bg "$(get_xres background:)"
set statusbar-fg "$(get_xres foreground:)"
set index-bg "$(get_xres background:)"
set index-fg "$(get_xres foreground:)"
set index-active-bg "$(get_xres foreground:)"
set index-active-fg "$(get_xres background:)"
set render-loading-bg "$(get_xres background:)"
set render-loading-fg "$(get_xres foreground:)"

set smooth-scroll true
set window-title-home-tilde true
set statusbar-basename true
set selection-clipboard clipboard
CONF
