#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <birthdays-file>"
    exit 1
fi

birthdays_file=$1
if [ ! -r "$birthdays_file" ]; then
    echo "Error: cannot read '$birthdays_file'"
    exit 1
fi

today=$(date +%d-%m)

while IFS=: read -r full_name login_name birthdate || [ -n "$full_name$login_name$birthdate" ]; do

    [ -z "$full_name$login_name$birthdate" ] && continue
    [ -z "$login_name" ] || [ -z "$birthdate" ] && continue

    full_name=$(printf '%s' "$full_name" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
    login_name=$(printf '%s' "$login_name" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
    birthdate=$(printf '%s' "$birthdate" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')

    [ "$birthdate" = "$today" ] || continue

    while read -r tty; do
        [ -n "$tty" ] || continue
        if command -v write >/dev/null 2>&1; then
            write "$login_name" "$tty" <<EOF
Happy birthday, $full_name! Have a wonderful day.
EOF
        fi
    done < <(who | awk -v user="$login_name" '$1 == user { print $2 }')
done < "$birthdays_file"
