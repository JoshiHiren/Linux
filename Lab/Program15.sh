#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

path=$1

if [ -L "$path" ]; then
    echo "Symbolic link"
elif [ -f "$path" ]; then
    echo "File"
elif [ -d "$path" ]; then
    echo "Directory"
else
    echo "Does not exist"
fi
