#!/usr/bin/env bash

killall dynamic_wallpaper
swww img "$(find ~/wallpaper/. -name "*.png" | shuf -n1)" --transition-type random