#!/usr/bin/env bash
path="${1/#$HOME/~}"
IFS='/' read -ra parts <<< "$path"
n=${#parts[@]}
if (( n > 3 )); then
    printf '…/%s/%s/%s\n' "${parts[n-3]}" "${parts[n-2]}" "${parts[n-1]}"
else
    printf '%s\n' "$path"
fi
