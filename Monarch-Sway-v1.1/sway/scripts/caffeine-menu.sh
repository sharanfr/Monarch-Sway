#!/bin/bash

PIDFILE="/tmp/monarch-caffeine.pid"

choice=$(printf "15 Minutes\n30 Minutes\n1 Hour\n2 Hours\nUnlimited\nDisable" \
| wofi --dmenu --prompt "Caffeine")

[ -z "$choice" ] && exit 0

if [ "$choice" = "Disable" ]; then
    if [ -f "$PIDFILE" ]; then
        kill "$(cat "$PIDFILE")" 2>/dev/null
        rm -f "$PIDFILE"
    fi

    notify-send "Caffeine" "Disabled"
    exit 0
fi

if [ -f "$PIDFILE" ]; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    rm -f "$PIDFILE"
fi

case "$choice" in
    "15 Minutes")
        timeout 15m systemd-inhibit --what=idle:sleep --why="Monarch Caffeine Mode" sleep infinity &
        notify-send "Caffeine" "Enabled • 15 Minutes"
        ;;
    "30 Minutes")
        timeout 30m systemd-inhibit --what=idle:sleep --why="Monarch Caffeine Mode" sleep infinity &
        notify-send "Caffeine" "Enabled • 30 Minutes"
        ;;
    "1 Hour")
        timeout 1h systemd-inhibit --what=idle:sleep --why="Monarch Caffeine Mode" sleep infinity &
        notify-send "Caffeine" "Enabled • 1 Hour"
        ;;
    "2 Hours")
        timeout 2h systemd-inhibit --what=idle:sleep --why="Monarch Caffeine Mode" sleep infinity &
        notify-send "Caffeine" "Enabled • 2 Hours"
        ;;
    "Unlimited")
        systemd-inhibit --what=idle:sleep --why="Monarch Caffeine Mode" sleep infinity &
        notify-send "Caffeine" "Enabled • Unlimited"
        ;;
esac

echo $! > "$PIDFILE"
