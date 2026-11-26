#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Error: '$1' is not a directory."
    exit 1
fi

# Resolve the directory so the archive can be saved beside it.
dir=$(cd -- "$1" && pwd -P) || exit 1
parent=$(dirname -- "$dir")
name=$(basename -- "$dir")
if [ "$dir" = "/" ]; then
    parent="/"
    name="."
fi

timestamp=$(date +%Y%m%d_%H%M%S)
backup="$parent/${name}_backup_${timestamp}.tar.gz"

if tar -czf "$backup" -C "$parent" "$name"; then
    echo "Backup created: $backup"
else
    echo "Error: backup could not be created."
    exit 1
fi
