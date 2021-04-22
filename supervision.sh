#!/bin/bash
# $1 : a directory name
# $2: log file for stdin output
# $3: log file for stderr output
# $4: a file size (in bytes)

generation=$(eval "pgrep -u $USER 'generation.sh' | wc -c");

if  [[ ! $generation -gt 1 ]] ;then
    echo "not launched" 
    exit
fi

destdir="/home/$USER/$1"

if  [[ ! -d $destdir ]] ; then
    echo "directory does not exist"
fi

cd $destdir
touch stats.log

# genSensorData.py is used to correctly identify and kill generation.sh
while [[ $(eval "pgrep -u $USER -f 'python3 genSensorData.py' | wc -c") -gt 1 ]];do
    pid=$( pgrep -u $USER -f 'python3 genSensorData.py');
    for file in $(ls $destdir | grep \.log);do
        size=$(stat -c%s "$destdir/$file");
        if [[ $size -gt $4 ]];then
            kill $pid;
            echo "too big";

            #drunken code start

            cat $2 | wc -l > stats.log
            cat $3 | wc -l >> stats.log
            
            #todo late when sober
            #sort $2
            #sort $3

            #drunken code stop

            tarfile=$(date +"%Y_%m_%d_%H_%M_%S")_logs
            tar cvf $tarfile.tar $2 $3 stats.log
        fi
    done
done
