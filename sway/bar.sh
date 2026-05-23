#!/bin/bash

# --- CLICK LOGIC ---
if [ "$1" == "click" ]; then
    X=$(swaymsg -t get_outputs | jq -r '.[0].cursor.x')
    WIDTH=$(swaymsg -t get_outputs | jq -r '.[0].rect.width')
    POS=$(( X * 100 / WIDTH ))

    if [ "$POS" -gt 90 ]; then
        swaymsg "exec bash -c 'opt=\$(echo -e \"Sleep\nReboot\nShutdown\" | wofi --dmenu --width 200); case \"\$opt\" in Sleep) systemctl suspend;; Reboot) systemctl reboot;; Shutdown) systemctl poweroff;; esac'" &
    elif [ "$POS" -gt 70 ]; then
        env GTK_USE_PORTAL=0 blueman-manager &
    elif [ "$POS" -gt 40 ]; then
        env GTK_USE_PORTAL=0 nm-connection-editor &
    fi
    exit 0
fi

# --- VISUAL FEED ---
while true; do
    # 1. WIFI: Name or "Not Connected"
    WIFI_NAME=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)
    if [ -z "$WIFI_NAME" ]; then WIFI_DISP="Not Connected"; else WIFI_DISP="$WIFI_NAME"; fi

    # 2. BLUETOOTH: "OFF" or "ON (Device Name)"
    BT_POWER=$(bluetoothctl show | grep "Powered: yes")
    if [ -z "$BT_POWER" ]; then 
        BT_DISP="OFF"
    else
        BT_DEV=$(bluetoothctl info | grep "Name" | cut -d ' ' -f 2-)
        if [ -z "$BT_DEV" ]; then BT_DISP="ON"; else BT_DISP="ON ($BT_DEV)"; fi
    fi

    # 3. BATTERY: Charging "Z" logic
    BAT_INFO=$(acpi -b)
    BAT_PERC=$(echo "$BAT_INFO" | awk -F', ' '{print $2}' | tr -d '%')
    if echo "$BAT_INFO" | grep -q "Charging"; then
        BAT_ICON=" ⚡" # This is your horizontal Z/lightning bolt
    else
        BAT_ICON=""
    fi

    # OUTPUT
    echo " $WIFI_DISP           $BT_DISP          $BAT_ICON $BAT_PERC%           $(date +'%I:%M %p')"
    
    sleep 2
done
