#!/bin/bash
pactl set-sink-volume @DEFAULT_SINK@ "$1"
vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po "[0-9]+(?=%)" | head -1)
notify-send -a "System" -r 9993 -u low "<b>Volume: $vol%</b>"