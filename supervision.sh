#!/bin/bash
# $1 : a directory name
# $2: log file for stdin output
# $3: log file for stderr output
# $4: time between each info
# $5: a file size (in bytes)
./generation.sh $4 $1 $2 $3 &
generation=$(eval "pgrep -u $USER 'generation.sh' | wc -c");

if  [[ ! $generation -gt 1 ]] ;then
    echo "not launched" 
    exit
fi

destdir="/home/$USER/$1"

if  [[ ! -d $destdir ]] ; then
    echo "directory does not exist"
fi
pushd $destdir

# genSensorData.py is used to correctly identify and kill generation.sh
while [[ $(eval "pgrep -u $USER 'generation.sh' | wc -c") -gt 1 ]];do
    for file in $(ls $destdir | grep "\.log");do
        pid=$( pgrep -u $USER 'generation.sh');
        size=$(stat -c%s "$destdir/$file");
        if [[ $size -gt $5 ]];then
            kill -s STOP $pid;
            echo "too big";
            #drunken code start
            
            touch stats.log
            cat $2 | wc -l > stats.log
            cat $3 | wc -l >> stats.log
            
            sort -V -o $2 $2
            sort -V -o $3 $3

            #drunken code stop

            tarfile=$(date +"%Y_%m_%d_%H_%M_%S")_logs
            tar cvf $tarfile.tar $2 $3 stats.log
            rm $2
            rm $3
            rm stats.log
            kill -s CONT $pid;
        fi
    done
done
