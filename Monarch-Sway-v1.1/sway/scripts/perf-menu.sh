#!/bin/bash

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2+$4)}')
RAM=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')
SWAP=$(free | awk '/Swap:/ {printf("%.0f"), $3/$2 * 100}')
UPTIME=$(uptime -p | sed 's/up //')
LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1)
DISK=$(df -h / | awk 'NR==2 {print $5}')
BAT=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null)

TEMP=$(sensors 2>/dev/null | awk '/Package id 0:/ {print $4; exit}')
[ -z "$TEMP" ] && TEMP="N/A"

printf "PERFORMANCE\n────────────\nCPU: %s%%\nRAM: %s%%\nSWAP: %s%%\nTEMP: %s\nUPTIME: %s\nLOAD: %s\nDISK: %s\nBATTERY: %s%%" \
"$CPU" "$RAM" "$SWAP" "$TEMP" "$UPTIME" "$LOAD" "$DISK" "$BAT" \
| wofi --dmenu --prompt "System Stats"
