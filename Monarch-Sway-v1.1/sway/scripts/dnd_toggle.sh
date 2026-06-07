#!/bin/bash
if makoctl mode | grep -q 'do-not-disturb'; then
    makoctl mode remove do-not-disturb > /dev/null 2>&1
else
    makoctl mode add do-not-disturb > /dev/null 2>&1
fi
pkill -RTMIN+8 waybar
