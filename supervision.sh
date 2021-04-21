#!/bin/bash
# $1 : a directory name
# $2: a file name
# $3: a file name
# $4: a file size (in bytes)
for file in $(ls | grep \.log);do
    size=$(stat -c%s "$file");
    echo $size;
    if [ $size -gt $4 ]
    then
    echo "too big";
    fi
done