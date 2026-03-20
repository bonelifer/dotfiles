#!/bin/bash

ramp_arr=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

# Sample once, parse per-core bars and overall %
mpstat_out=$(mpstat -P ALL 1 1)

bars=""
while IFS= read -r line; do
    val=$(echo "$line" | awk '{printf "%0.2f", $3}')
    idx=$(echo "scale=4; $val/12.5" | bc)
    intidx=$(($(printf "%.0f" "$idx")))
    bars="${bars}${ramp_arr[$intidx]}"
done < <(echo "$mpstat_out" | grep -E 'Average:\s+[0-9]+')

overall=$(echo "$mpstat_out" | awk '/^Average/ && !/CPU/ {printf "%.0f", 100 - $NF}')

if [ "$overall" -ge 80 ]; then
    color="#FF4444"
elif [ "$overall" -ge 50 ]; then
    color="#FFAA00"
else
    color=""
fi

echo "$bars ${overall}%"
echo ""
echo "$color"
