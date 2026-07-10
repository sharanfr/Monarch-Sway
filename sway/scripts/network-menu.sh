#!/bin/bash

# Rescan in background
nmcli device wifi rescan >/dev/null 2>&1
sleep 1

CURRENT=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)

MENU=""

if [ -n "$CURRENT" ]; then
    MENU="󰤨  $CURRENT    (Connected)\n"
fi

MENU="$MENU$(nmcli -t -f SSID,SIGNAL,SECURITY dev wifi list | sort -u | while IFS=: read -r SSID SIGNAL SECURITY
do
    [ -z "$SSID" ] && continue

    if [ "$SSID" = "$CURRENT" ]; then
        continue
    fi

    if [ "$SIGNAL" -ge 80 ]; then
        ICON="󰤨"
    elif [ "$SIGNAL" -ge 60 ]; then
        ICON="󰤥"
    elif [ "$SIGNAL" -ge 40 ]; then
        ICON="󰤢"
    else
        ICON="󰤟"
    fi

    echo "$ICON  $SSID"
done)"

CHOICE=$(echo -e "$MENU" | wofi --dmenu --prompt "Network")

[ -z "$CHOICE" ] && exit

SSID=$(echo "$CHOICE" \
| sed 's/^󰤨  //' \
| sed 's/^󰤥  //' \
| sed 's/^󰤢  //' \
| sed 's/^󰤟  //' \
| sed 's/    (Connected)//')

if [ "$SSID" = "$CURRENT" ]; then
    notify-send "Network" "Already connected • $SSID"
    exit
fi

KNOWN=$(nmcli -t -f NAME connection | grep -Fx "$SSID")

if [ -n "$KNOWN" ]; then

    if nmcli connection up "$SSID" >/dev/null 2>&1; then
        notify-send "Network" "Connected • $SSID"
    else
        notify-send "Network" "Connection Failed"
    fi

    exit
fi

PASSWORD=$(wofi \
--dmenu \
--password \
--prompt "Password")

[ -z "$PASSWORD" ] && exit

if nmcli dev wifi connect "$SSID" password "$PASSWORD" >/dev/null 2>&1
then
    nmcli connection modify "$SSID" connection.autoconnect yes

    notify-send "Network" "Connected • $SSID"
else
    notify-send "Network" "Wrong Password"
fi
