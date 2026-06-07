#!/bin/bash

LOW20_SENT=0
LOW10_SENT=0
LAST_STATUS=""

while true; do
    BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

    # Charger state changes
    if [ "$STATUS" != "$LAST_STATUS" ]; then
        case "$STATUS" in
            Charging)
                notify-send "Power" "Charging Started (${BATTERY}%)"
                ;;
            Discharging)
                notify-send "Power" "Running on Battery (${BATTERY}%)"
                ;;
            Full)
                notify-send "Power" "Battery Fully Charged"
                ;;
        esac

        LAST_STATUS="$STATUS"
    fi

    # Low battery warnings
    if [ "$STATUS" = "Discharging" ]; then

        if [ "$BATTERY" -le 20 ] && [ "$LOW20_SENT" -eq 0 ]; then
            notify-send "Battery" "20% Remaining"
            LOW20_SENT=1
        fi

        if [ "$BATTERY" -le 10 ] && [ "$LOW10_SENT" -eq 0 ]; then
            notify-send "Battery" "10% Remaining • Plug in Charger"
            LOW10_SENT=1
        fi

    fi

    # Reset notification flags after recharge
    if [ "$BATTERY" -ge 25 ]; then
        LOW20_SENT=0
    fi

    if [ "$BATTERY" -ge 15 ]; then
        LOW10_SENT=0
    fi

    sleep 1
done
