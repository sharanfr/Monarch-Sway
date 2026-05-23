#!/bin/bash

case "$1" in
  up) brightnessctl set +5% ;;
  down) brightnessctl set 5%- ;;
esac

BRT=$(brightnessctl get)
MAX=$(brightnessctl max)
PERCENT=$(( BRT * 100 / MAX ))

notify-send -h string:x-canonical-private-synchronous:osd "BRT ${PERCENT}%"
