#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

file=$1

if [ ! -e "$file" ]; then
    echo "Does not exist: $file"
    exit 0
fi

echo "Exists: Yes"
if [ -f "$file" ]; then
    echo "Type: Regular file"
elif [ -d "$file" ]; then
    echo "Type: Directory"
elif [ -L "$file" ]; then
    echo "Type: Symbolic link"
else
    echo "Type: Other"
fi

echo "Size: $(stat -c '%s bytes' -- "$file")"
echo "Permissions: $(stat -c '%A (%a)' -- "$file")"
echo "Owner: $(stat -c '%U' -- "$file")"
echo "Modification time: $(stat -c '%y' -- "$file")"
