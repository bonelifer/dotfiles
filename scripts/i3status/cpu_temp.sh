#!/bin/bash

temp=$(sensors | grep -e 'Tctl\|CPU:' | awk '{print $2}' | head -n 1)
num=$(echo "$temp" | tr -d '+°C')

if (( $(echo "$num >= 80" | bc -l) )); then
    color="#FF4444"
elif (( $(echo "$num >= 60" | bc -l) )); then
    color="#FFAA00"
else
    color=""
fi

echo "$temp"
echo ""
echo "$color"
