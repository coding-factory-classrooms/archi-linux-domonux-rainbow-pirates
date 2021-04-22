#!/bin/bash
# $1: time in miliseconds between each info sent by the script
# $2: a directory name
# $3: log file for stdin output
# $4: log file for stderr output

gcc genTick.c -o genTick;

destdir="/home/$USER/$2"

if [[ ! -d $destdir ]] ; then
    echo "directory does not exist, creating one"
    mkdir $destdir
fi

if [[ ! -f "$destdir/$3" ]] ; then
    touch "$destdir/$3"
fi


if [[ ! -f "$destdir/$4" ]] ; then
    touch "$destdir/$4"
fi

regex="Sensor|Value"

echo "User: $UID"

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

