#!/bin/bash

echo "Linux distribution:"
if [ -r /etc/os-release ]; then
    . /etc/os-release
    echo "${PRETTY_NAME:-Unknown}"
else
    echo "Unknown"
fi

echo "Kernel version: $(uname -r)"
echo "Hostname: $(hostname)"
echo "CPU architecture: $(uname -m)"
echo "Memory information:"
free -h | awk 'NR == 1 || NR == 2'
echo "System uptime: $(uptime -p)"
