#!/bin/bash
gcc genTick.c -o genTick;

destdir=./logs/$2
regex="Sensor|Value"

./genTick $1 | python3 genSensorData.py | {
    while IFS= read -r line; do
        
        # Use separator ';' to store in array values differents datas for parsing
        OLDIFS=$IFS
        IFS=';'
        read -a values <<< "$line"
        IFS=$OLDIFS
        str_to_store=""
        for val in ${values[@]};
        do
            if [[ $val =~ $regex ]]
            then
                str_to_store+="$val;"
            fi
        done
        echo $str_to_store >> $destdir/$3
    done
}

