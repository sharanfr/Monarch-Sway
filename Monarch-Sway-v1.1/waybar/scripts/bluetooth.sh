#!/bin/bash
# Checks for connected bluetooth devices and battery levels
info=$(bluetoothctl info)
name=$(echo "$info" | grep "Name" | cut -d ' ' -f 2-)
batt=$(echo "$info" | grep "Battery Percentage" | awk -F '[()]' '{print $2}' | tr -d '%')

if [ -z "$name" ]; then
    echo ""
else
    if [ -z "$batt" ]; then
        echo " $name"
    else
        echo " $name ($batt%)"
    fi
fi
