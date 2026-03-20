#!/bin/bash

pct=$(df -h / | awk '/\// {print $5}')
num=${pct%\%}

if [ "$num" -ge 90 ]; then
    color="#FF4444"
elif [ "$num" -ge 70 ]; then
    color="#FFAA00"
else
    color=""
fi

echo "$pct"
echo ""
echo "$color"
