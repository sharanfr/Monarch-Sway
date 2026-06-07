#!/bin/bash

choice=$(printf "4500K\n4000K\n3500K\n3000K\nDisable" \
| wofi --dmenu --prompt "Night Light")

[ -z "$choice" ] && exit 0

pkill gammastep 2>/dev/null

case "$choice" in
    "4500K")
        gammastep -O 4500 &
        notify-send "Night Light" "Enabled • 4500K"
        ;;
    "4000K")
        gammastep -O 4000 &
        notify-send "Night Light" "Enabled • 4000K"
        ;;
    "3500K")
        gammastep -O 3500 &
        notify-send "Night Light" "Enabled • 3500K"
        ;;
    "3000K")
        gammastep -O 3000 &
        notify-send "Night Light" "Enabled • 3000K"
        ;;
    "Disable")
        notify-send "Night Light" "Disabled"
        ;;
esac
