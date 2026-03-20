#!/bin/bash

# Get the default sink (audio output device)
default_sink=$(pactl get-default-sink)

# Get the current volume level of the default sink
volume=$(pactl get-sink-volume "$default_sink" | awk -F'/' '{print $2}' | tr -d '%')

echo "$volume%"

