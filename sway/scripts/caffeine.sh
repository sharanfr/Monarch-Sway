#!/bin/bash

PIDFILE="/tmp/monarch-caffeine.pid"

if [ -f "$PIDFILE" ]; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    rm -f "$PIDFILE"
    notify-send "Caffeine" "Disabled"
else
    systemd-inhibit --what=idle:sleep --why="Monarch Caffeine Mode" sleep infinity &
    echo $! > "$PIDFILE"
    notify-send "Caffeine" "Enabled"
fi
