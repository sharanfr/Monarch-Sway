#!/bin/bash

choice=$(printf "4500K\n4000K\n3500K\n3000K\nDisable" \
| wofi --dmenu --prompt "Night Light")

[ -z "$choice" ] && exit 0

# Stop any existing Night Light instance
pkill gammastep 2>/dev/null

case "$choice" in
    "4500K")
        nohup gammastep -O 4500 >/dev/null 2>&1 &
        disown
        sleep 0.2

        if pgrep -x gammastep >/dev/null; then
            notify-send "Night Light" "Enabled • 4500K"
        else
            notify-send "Night Light" "Failed to start"
        fi
        ;;

    "4000K")
        nohup gammastep -O 4000 >/dev/null 2>&1 &
        disown
        sleep 0.2

        if pgrep -x gammastep >/dev/null; then
            notify-send "Night Light" "Enabled • 4000K"
        else
            notify-send "Night Light" "Failed to start"
        fi
        ;;

    "3500K")
        nohup gammastep -O 3500 >/dev/null 2>&1 &
        disown
        sleep 0.2

        if pgrep -x gammastep >/dev/null; then
            notify-send "Night Light" "Enabled • 3500K"
        else
            notify-send "Night Light" "Failed to start"
        fi
        ;;

    "3000K")
        nohup gammastep -O 3000 >/dev/null 2>&1 &
        disown
        sleep 0.2

        if pgrep -x gammastep >/dev/null; then
            notify-send "Night Light" "Enabled • 3000K"
        else
            notify-send "Night Light" "Failed to start"
        fi
        ;;

    "Disable")
        pkill gammastep 2>/dev/null
        notify-send "Night Light" "Disabled"
        ;;
esac
