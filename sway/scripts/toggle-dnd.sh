#!/bin/bash

MODE=$(makoctl mode)

if [ "$MODE" = "default" ]; then
    notify-send "Do Not Disturb" "Enabled"
    sleep 1
    makoctl mode -a do-not-disturb
else
    makoctl mode -r do-not-disturb
    notify-send "Do Not Disturb" "Disabled"
fi
