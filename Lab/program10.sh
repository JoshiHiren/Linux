#!/bin/bash

dir="${1:-.}"

echo "File count by extension in: $dir"

for file in "$dir"/*
do
    if [ -f "$file" ]; then
        name=$(basename "$file")

        if [[ "$name" == *.* && "$name" != .* ]]; then
            ext="${name##*.}"
            echo "$ext"
        else
            echo "no_extension"
        fi
    fi
done | sort | uniq -c
