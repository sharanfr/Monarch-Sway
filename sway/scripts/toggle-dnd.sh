#!/bin/bash

MODE=$(makoctl mode)

if [ "$MODE" = "default" ]; then
    makoctl mode -s do-not-disturb
    notify-send "DND enabled"
else
    makoctl mode -s default
    notify-send "DND disabled"
fi
