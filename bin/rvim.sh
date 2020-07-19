#!/bin/bash
flag=1

if [ $# == 0 ]; then
    ls
    flag=0
else
    for arg in "$@"
    do
        if [ -d $arg ]; then
            flag=0
        fi
    done
fi

if [ $flag == 1 ]; then
    nvr --remote $@
else
    echo "This needs file names."
fi
