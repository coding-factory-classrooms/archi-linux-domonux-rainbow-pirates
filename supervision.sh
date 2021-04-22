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

# genSensorData.py is used to correctly identify and kill generation.sh
while [[ $(eval "pgrep -u $USER -f 'python3 genSensorData.py' | wc -c") -gt 1 ]];do
    pid=$( pgrep -u $USER -f 'python3 genSensorData.py');
    echo $pid
    for file in $(ls $destdir | grep \.log);do
        size=$(stat -c%s "$destdir/$file");
        if [[ $size -gt $4 ]];then
            kill $pid;
            echo "too big";
            tarfile=$(date +"%Y_%m_%d_%H_%M_%S")_logs
            tar cvf $tarfile.tar $2 $3
        fi
    done
done
