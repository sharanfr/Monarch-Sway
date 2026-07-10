#!/bin/bash

STATUS=""

# DND
if makoctl mode 2>/dev/null | grep -q "^do-not-disturb$"; then
    STATUS="$STATUS • "
fi

# Caffeine
PIDFILE="/tmp/monarch-caffeine.pid"

if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")

    if kill -0 "$PID" 2>/dev/null; then
        STATUS="$STATUS • "
    else
        rm -f "$PIDFILE"
    fi
fi

# Night Light
if pgrep -x gammastep >/dev/null; then
    STATUS="$STATUS • 󰖔"
fi

echo "$(date '+%H:%M')$STATUS • $(date '+%a %d %b')"
