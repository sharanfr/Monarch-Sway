#!/bin/bash

choice=$(printf "Night Light\nCaffeine" | wofi --dmenu --prompt "Display")

case "$choice" in
    "Night Light")
        ~/.config/sway/scripts/nightlight-menu.sh
        ;;
    "Caffeine")
        ~/.config/sway/scripts/caffeine-menu.sh
        ;;
esac
