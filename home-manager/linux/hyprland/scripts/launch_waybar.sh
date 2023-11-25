#!/usr/bin/env bash

killall .waybar-wrapped
SDIR="$HOME/.config/waybar"
waybar -c "$SDIR"/config -s "$SDIR"/style.css > /dev/null 2>&1 & 