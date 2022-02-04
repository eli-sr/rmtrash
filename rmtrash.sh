#!/usr/bin/bash

if [ -z "$1" ];then
    echo "rmtrash: missing operand"
    exit 1
else
    for arg in "$@"; do
        /usr/bin/ls ~/.local/share/Trash/files/$arg &>/dev/null
        success=$(echo $?)
        if [ $success == '0' ]; then
            i=1
            /usr/bin/ls ~/.local/share/Trash/files/$arg\($i\) &>/dev/null
            success=$(echo $?)
            while [ $success == '0' ]; do
                i=$((i + 1))
                /usr/bin/ls ~/.local/share/Trash/files/$arg\($i\) &>/dev/null
                success=$(echo $?)
            done
            /usr/bin/mv $arg ~/.local/share/Trash/files/$arg\($i\)
        else
            /usr/bin/mv $arg ~/.local/share/Trash/files
        fi
    done
    exit 0
fi
