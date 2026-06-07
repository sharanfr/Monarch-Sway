#!/bin/bash

FILE=$(find "$HOME" \
    -path "$HOME/.cache" -prune -o \
    -path "$HOME/.local/share/Trash" -prune -o \
    -type f -print 2>/dev/null \
    | wofi --dmenu --prompt "Files")

[ -z "$FILE" ] && exit 0

nautilus --select "$FILE"
