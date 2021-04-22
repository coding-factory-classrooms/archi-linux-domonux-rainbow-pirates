#!/bin/bash
# $1 : a directory name
# $2: a file name
# $3: a file name
# $4: a file size (in bytes)
generation=$(eval "pgrep -u $USER 'generation.sh' | wc -c");

if  [[ ! $generation -gt 1 ]] ;then
    echo "not launched" 
    exit
fi

if  [[ ! -d $1 ]] ; then
    echo "directory does not exist"
    exit
fi

while [[ $(eval "pgrep -u $USER 'generation.sh' | wc -c") -gt 1 ]];do
    pid=$( pgrep -u $USER 'generation.sh');
    for file in $(ls $1 | grep \.log);do
        size=$(stat -c%s "$1/$file");
        if [[ $size -gt $4 ]];then
            kill $pid;
            echo "too big";
        fi
    done
done