#!/bin/bash
# Usage: charcount [path] [extension]
# Description: Count the number of characters in a file or files in a directory
# Example: charcount ./docs md

cnt=0
path=$1
ext=$2

__count_path__() {
    if [[ -f $1 ]]; then
        if [[ $1 == *.$2 || -z $ext ]]; then
            cnt=$((cnt + $(wc -m < "$1" 2> /dev/null)))
        fi
        return
    elif [[ -d $1 ]]; then
        for f in "$1"/*; do
            __count_path__ "$f" "$2"
        done
    fi
}

if [[ -z $path ]]; then
    path="$(pwd)"
fi

if [[ ! -e $path ]]; then
    echo "Error: $path does not exist"
    exit 1
fi

__count_path__ "$path" "$ext"
echo $cnt