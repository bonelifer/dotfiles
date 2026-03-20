#!/bin/bash
# Fetch weather information from wttr.in
#curl -s "wttr.in/North_Hollywood?format=1" | tr -s ' '

# Get the weather data for North Hollywood
weather_data=$(curl -s "wttr.in/North_Hollywood?format=1")
weather_data_c=$(curl -s "wttr.in/North_Hollywood?format=1&metric")

# Extract the relevant information from the weather data
weather_icon=$(echo "$weather_data" | awk '{print $1}')
temp_f=$(echo "$weather_data" | awk '{print $2}' | tr -d '°F' | sed 's/\+//')
temp_c=$(echo "$weather_data_c" | awk '{print $2}' | tr -d '°C' | sed 's/\+//')
# Display the weather information
echo "$weather_icon $temp_f°F|$temp_c°C"

