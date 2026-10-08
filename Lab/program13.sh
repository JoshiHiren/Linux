#!/bin/bash

echo "Enter directory:"
read dir

echo "Enter filename:"
read filename

if [ ! -d "$dir" ]; then
    echo "Directory does not exist."
    exit 1
fi

echo "Searching for $filename in $dir..."

find "$dir" -type f -name "$filename"
