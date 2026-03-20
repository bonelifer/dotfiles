#!/bin/bash

# Get interface used for default route (if any)
INTERFACE=$(ip route get 1 2>/dev/null | awk '{print $5; exit}')

# Fallback: active wireless interface
if [ -z "$INTERFACE" ]; then
  INTERFACE=$(iw dev 2>/dev/null | awk '/Interface/ {print $2; exit}')
fi

# Final fallback: first non-loopback up interface
if [ -z "$INTERFACE" ]; then
  INTERFACE=$(ip -o link show up | awk -F': ' '$2!="lo"{print $2; exit}')
fi

# Get IPv4 address
IP=$(ip -4 addr show "$INTERFACE" 2>/dev/null | awk '/inet /{print $2}' | cut -d'/' -f1)

# If wireless, get SSID (use iw if available)
SSID=""
if iw dev 2>/dev/null | grep -q "^"; then
  if iw dev "$INTERFACE" info >/dev/null 2>&1; then
    SSID=$(iw dev "$INTERFACE" link 3>/dev/null | awk -F': ' '/SSID/ {print $2; exit}')
  fi
fi

# Output
if [ -n "$IP" ]; then
  if [ -n "$SSID" ]; then
    echo "  $SSID ($IP)"
  else
    echo " $INTERFACE ($IP)"
  fi
else
  echo "no ip"
fi

