#!/bin/bash

output="b.txt","a.txt"

> "$output"

for file in "$@"
do
    echo "*** filename : $file ***" >> "$output"
    cat "$file" >> "$output"
    echo -e "\n" >> "$output"
done

echo "Files combined into $output"
