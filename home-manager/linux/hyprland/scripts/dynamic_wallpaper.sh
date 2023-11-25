#!/usr/bin/env bash

swww img "$(find ~/wallpaper/. -name "*.png" | shuf -n1)" --transition-type random
OLD_PID=$!
while true; do
    sleep 120
swww img "$(find ~/wallpaper/. -name "*.png" | shuf -n1)" --transition-type random
    NEXT_PID=$!
    sleep 5
    kill $OLD_PID
    OLD_PID=$NEXT_PID
done