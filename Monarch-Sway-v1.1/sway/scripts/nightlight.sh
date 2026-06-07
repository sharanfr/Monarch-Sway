#!/bin/bash

if pgrep -x gammastep >/dev/null; then
    pkill gammastep
    notify-send "Night Light" "Disabled"
else
    gammastep -O 3500 &
    notify-send "Night Light" "Enabled (3500K)"
fi
