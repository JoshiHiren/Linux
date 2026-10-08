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

find "$dir" -type f \( -name "*.obj" -o -name "*.lst" -o -size 0 \) -delete

echo "Deleted .obj, .lst and zero-byte files."
