#!/bin/bash
# $1: time in miliseconds between each info sent by the script
gcc genTick.c -o genTick;

destdir=./logs/$2

if [ -f "$destdir" ]
then
    echo "Dir exist"
fi

./genTick $1 | python3 genSensorData.py | {
    while IFS= read -r line; do
        echo $line >> $destdir/$3
    done
}

