#!/bin/bash

# Get the default network interface
INTERFACE=$(ip route get 1 | awk '{print $5}')

# Get the local IP address
LOCAL_IP=$(ip addr show $INTERFACE | awk '/inet /{print $2}' | cut -d'/' -f1)

echo "$LOCAL_IP"

