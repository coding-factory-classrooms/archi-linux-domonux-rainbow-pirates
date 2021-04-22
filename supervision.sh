#!/bin/bash
# $1 : a directory name
# $2: a file name
# $3: a file name
# $4: a file size (in bytes)

if ! $(pgrep -x generation.sh);then
    echo "not launched";
    exit
fi
if ! [[! -f $1] then];then
    echo "directory does not exist"
    exit
fi
pid=$(pgrep -u $USER generation.sh )
while $(pgrep -x generation.sh);do
    for file in $(ls | grep \.log);do
        size=$(stat -c%s "$file");
        echo $size;
        if [ $size -gt $4 ] then
            kill $pid;
            echo "too big";
        fi
    done
done