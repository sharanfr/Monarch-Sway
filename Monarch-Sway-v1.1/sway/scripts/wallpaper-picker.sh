#!/bin/bash

WALLDIR="$HOME/Wallpapers"
STATE="$HOME/.config/sway/current_wallpaper"

selection=$(find "$WALLDIR" -maxdepth 1 -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" -o \
    -iname "*.svg" -o \
    -iname "*.webp" -o \
    -iname "*.bmp" -o \
    -iname "*.gif" -o \
    -iname "*.tiff" \
\) -printf "%f\n" | sort | wofi --dmenu --prompt "Choose Wallpaper")

[ -z "$selection" ] && exit 0

img="$WALLDIR/$selection"

pkill swaybg
swaybg -i "$img" -m fill &

echo "$img" > "$STATE"
