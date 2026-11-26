#!/bin/bash

while true; do
    echo
    echo "1. Search by filename"
    echo "2. Search by extension"
    echo "3. Search by size"
    echo "4. Search by owner"
    echo "5. Search by permissions"
    echo "6. Modified within days"
    echo "7. Not modified for days"
    echo "8. Modified between dates"
    echo "9. Search with multiple criteria"
    echo "10. Count files by filename"
    echo "11. Exit"
    read -r -p "Choose (1-11): " choice

    if [[ "$choice" == 11 ]]; then
        echo "Goodbye"
        break
    fi

    read -r -p "Directory to search [.]: " dir
    dir=${dir:-.}
    if [[ ! -d "$dir" ]]; then
        echo "Directory not found"
        continue
    fi

    args=()
    case "$choice" in
        1|10)
            read -r -p "Filename pattern (e.g. *.txt): " name
            [[ -n "$name" ]] || { echo "Filename is required"; continue; }
            args+=( -name "$name" )
            ;;
        2)
            read -r -p "Extension (e.g. txt): " ext
            ext=${ext#.}
            [[ -n "$ext" ]] || { echo "Extension is required"; continue; }
            args+=( -name "*.$ext" )
            ;;
        3)
            read -r -p "Size filter (e.g. +10M or -500k): " size
            [[ "$size" =~ ^[+-]?[0-9]+[cwbkMG]?$ ]] || { echo "Invalid size"; continue; }
            args+=( -size "$size" )
            ;;
        4)
            read -r -p "Owner username: " owner
            [[ -n "$owner" ]] || { echo "Owner is required"; continue; }
            args+=( -user "$owner" )
            ;;
        5)
            read -r -p "Permission in octal (e.g. 644): " perm
            [[ "$perm" =~ ^[0-7]{3,4}$ ]] || { echo "Invalid permission"; continue; }
            args+=( -perm "$perm" )
            ;;
        6|7)
            read -r -p "Number of days: " days
            [[ "$days" =~ ^[0-9]+$ ]] || { echo "Enter a whole number"; continue; }
            if [[ "$choice" == 6 ]]; then
                args+=( -mmin "-$((days * 1440))" )
            else
                args+=( -mmin "+$((days * 1440))" )
            fi
            ;;
        8)
            read -r -p "Start date (YYYY-MM-DD): " start
            read -r -p "End date (YYYY-MM-DD): " end
            if ! date -d "$start" >/dev/null 2>&1 || ! date -d "$end" >/dev/null 2>&1; then
                echo "Invalid date"
                continue
            fi
            args+=( -newermt "$start 00:00:00" ! -newermt "$end 23:59:59" )
            ;;
        9)
            read -r -p "Filename pattern (Enter to skip): " name
            read -r -p "Owner (Enter to skip): " owner
            read -r -p "Permission (Enter to skip): " perm
            read -r -p "Size filter (Enter to skip): " size
            [[ -z "$name" ]] || args+=( -name "$name" )
            [[ -z "$owner" ]] || args+=( -user "$owner" )
            if [[ -n "$perm" ]]; then
                [[ "$perm" =~ ^[0-7]{3,4}$ ]] || { echo "Invalid permission"; continue; }
                args+=( -perm "$perm" )
            fi
            if [[ -n "$size" ]]; then
                [[ "$size" =~ ^[+-]?[0-9]+[cwbkMG]?$ ]] || { echo "Invalid size"; continue; }
                args+=( -size "$size" )
            fi
            ((${#args[@]} > 0)) || { echo "Enter at least one search condition"; continue; }
            ;;
        *)
            echo "Choose a number from 1 to 11"
            continue
            ;;
    esac

    if [[ "$choice" == 10 ]]; then
        find "$dir" -type f "${args[@]}" -print 2>/dev/null | wc -l
    else
        find "$dir" -type f "${args[@]}" -print 2>/dev/null
    fi
done
