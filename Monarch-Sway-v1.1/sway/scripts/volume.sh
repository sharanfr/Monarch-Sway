#!/bin/bash

case "$1" in
  up) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ ;;
  down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
  mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
esac

VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o MUTED)

if [ "$MUTED" = "MUTED" ]; then
    notify-send -h string:x-canonical-private-synchronous:osd "MUTED"
else
    notify-send -h string:x-canonical-private-synchronous:osd "VOL ${VOL}%"
fi
