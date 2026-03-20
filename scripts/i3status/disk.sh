#!/bin/bash
echo "$(df -h / | awk '/\// {print $5}')"

