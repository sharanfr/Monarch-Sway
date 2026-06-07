#!/bin/bash

img="/tmp/swaylock.png"

grim "$img"
convert "$img" -scale 10% -blur 0x3 -scale 1000% "$img"

swaylock \
-f \
-i "$img" \
--indicator-radius 100 \
--indicator-thickness 8 \
--ring-color 89b4fa \
--inside-color 1e1e2ecc \
--line-color 00000000 \
--separator-color 00000000 \
--key-hl-color a6e3a1 \
--bs-hl-color f38ba8 \
--text-color cdd6f4 \
--inside-clear-color 313244cc \
--ring-clear-color f9e2af \
--inside-ver-color 313244cc \
--ring-ver-color 89b4fa \
--inside-wrong-color 313244cc \
--ring-wrong-color f38ba8

rm -f "$img"
