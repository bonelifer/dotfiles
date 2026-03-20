#!/bin/bash

# Get the total memory
total_memory=$(free -m | awk '/Mem:/ {print $2}')

# Get the used memory
used_memory=$(free -m | awk '/Mem:/ {print $3}')

# Calculate the percentage of memory in use
memory_percent=$((used_memory * 100 / total_memory))

# Format the used memory in gigabytes
used_memory_gb=$(echo "scale=2; $used_memory / 1024" | bc)

echo "$used_memory_gb GB ($memory_percent%)"

