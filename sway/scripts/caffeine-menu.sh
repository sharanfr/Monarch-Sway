#!/bin/bash

PIDFILE="/tmp/monarch-caffeine.pid"

choice=$(printf "15 Minutes\n30 Minutes\n1 Hour\n2 Hours\nUnlimited\nDisable" \
| wofi --dmenu --prompt "Caffeine")

[ -z "$choice" ] && exit 0

# Disable existing session
if [ "$choice" = "Disable" ]; then
    if [ -f "$PIDFILE" ]; then
        PID=$(cat "$PIDFILE")

        if kill -0 "$PID" 2>/dev/null; then
            kill "$PID"
        fi

        rm -f "$PIDFILE"
    fi

    notify-send "Caffeine" "Disabled"
    exit 0
fi

# Stop any existing session before starting a new one
if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")

    if kill -0 "$PID" 2>/dev/null; then
        kill "$PID"
    fi

    rm -f "$PIDFILE"
fi

case "$choice" in

    "15 Minutes")
        (
            timeout 15m systemd-inhibit \
                --what=idle:sleep \
                --why="Monarch Caffeine Mode" \
                sleep infinity

            rm -f "$PIDFILE"
            notify-send "Caffeine" "Session Ended"
        ) &
        echo $! > "$PIDFILE"
        notify-send "Caffeine" "Enabled • 15 Minutes"
        ;;

    "30 Minutes")
        (
            timeout 30m systemd-inhibit \
                --what=idle:sleep \
                --why="Monarch Caffeine Mode" \
                sleep infinity

            rm -f "$PIDFILE"
            notify-send "Caffeine" "Session Ended"
        ) &
        echo $! > "$PIDFILE"
        notify-send "Caffeine" "Enabled • 30 Minutes"
        ;;

    "1 Hour")
        (
            timeout 1h systemd-inhibit \
                --what=idle:sleep \
                --why="Monarch Caffeine Mode" \
                sleep infinity

            rm -f "$PIDFILE"
            notify-send "Caffeine" "Session Ended"
        ) &
        echo $! > "$PIDFILE"
        notify-send "Caffeine" "Enabled • 1 Hour"
        ;;

    "2 Hours")
        (
            timeout 2h systemd-inhibit \
                --what=idle:sleep \
                --why="Monarch Caffeine Mode" \
                sleep infinity

            rm -f "$PIDFILE"
            notify-send "Caffeine" "Session Ended"
        ) &
        echo $! > "$PIDFILE"
        notify-send "Caffeine" "Enabled • 2 Hours"
        ;;

    "Unlimited")
        systemd-inhibit \
            --what=idle:sleep \
            --why="Monarch Caffeine Mode" \
            sleep infinity &

        echo $! > "$PIDFILE"
        notify-send "Caffeine" "Enabled • Unlimited"
        ;;

esac
