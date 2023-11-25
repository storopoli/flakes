#!/usr/bin/env bash

config_file="$HOME/.config/hypr/hyprland.conf"
keybinds=$(grep -oP '(?<=bind = ).*' $config_file)
keybinds=$(echo "$keybinds" | sed 's/,\([^,]*\)$/ = \1/' | sed 's/, exec//g' | sed 's/^,//g')
rofi -dmenu -p "Keybinds" -theme "$HOME/.config/rofi/powermenu_theme.rasi" <<< "$keybinds"
