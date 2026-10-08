#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

dir="$1"

if [ ! -d "$dir" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

echo "Zero-byte files in $dir:"

find "$dir" -type f -size 0
