#!/bin/bash
# Fetch weather information from Open-Meteo API

data=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=34.14&longitude=-118.41&current=temperature_2m,wind_speed_10m&hourly=temperature_2m")

temp_c=$(echo "$data" | jq -r '.current.temperature_2m')
temp_f=$(echo "$temp_c" | awk '{printf "%.1f", $1 * 9/5 + 32}')

echo "${temp_f}°F | ${temp_c}°C"
