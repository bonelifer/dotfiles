#!/bin/bash

# Define array
ramp_arr=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

sar -P ALL 1 1 | grep -E 'Average:\s+[0-9]+' | while read -r line; do
    val=$(echo "$line" | awk '{cpu_usage=$3} END {printf "%0.2f", cpu_usage}')
    idx=$(echo "scale=4; $val/12.5" | bc)
    intidx=$(($(printf "%.0f" "$idx")))
    printf "${ramp_arr[$intidx]}"
done

mpstat_output=$(mpstat 2 1 | awk '/^Average/ {print $3}')
echo "$ramp_arr $mpstat_output"

