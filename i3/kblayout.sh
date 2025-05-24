#!/bin/bash

while :; do
    layout=$(setxkbmap -query | awk '/layout:/ {print $2}')
    variant=$(setxkbmap -query | awk '/variant:/ {print $2}')
    current_layout=$(echo $layout | cut -d, -f1)

    if [ "$variant" = "" ]; then
        echo "⌨ ${current_layout^^}"
    else
        echo "⌨ ${variant^^}"
    fi
    sleep 1
done
