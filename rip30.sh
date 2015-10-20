#!/bin/bash
##record 30 songs from internet radio

DIRNAME=cast_`date +%m-%d-%y`
FILENAME=psychedelik_amb_%m-%d-%y-%H-%M-%S
URL=http://195.154.86.144:8002/relay.mp3?icy=http
mkdir $DIRNAME
cd $DIRNAME

function recordTrack {
    echo "recordTrack called FILENAME:$FILENAME URL: $URL" 
    icecream --name=$FILENAME --stop=20mb $URL
}

function filterSmallFiles {
    find -name "*.mp3" -size -1024k -delete
}

function cutPrefixAds {
  FILES=`find . -maxdepth 1  -type f  -name "*.mp3" -printf '%f\n'`
  for i in $FILES
  do 
    file="`echo -n "$i" `"
    echo converting $file
    sox $file trm_$file trim 5
  done
  for i in $FILES
  do 
    file="`echo -n "$i" `"
    echo deleteng $file
    rm $file
  done
}


COUNTER=0
while [  $COUNTER -lt 6 ]; do
    echo The counter is $COUNTER
    let COUNTER=COUNTER+1 
    recordTrack
done

filterSmallFiles
cutPrefixAds
exit