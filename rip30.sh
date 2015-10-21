#!/bin/bash
##record 30 songs from internet radio
TRACK_COUNT=6
DIRNAME=cast_`date +%m-%d-%y`
FILENAME_PREFIX=psychedelik_amb_
URL=http://195.154.86.144:8002/relay.mp3?icy=http

function printUsage {
    echo "--------------"    
    echo "usage:"    
    echo "run30.sh <trackCount>"    
    echo "--------------"    
}

function initTrackCount {
  if [ -z "$1" ]
  then  
  ##alredy init by default value
  TRACK_COUNT=$TRACK_COUNT;
  else 
  TRACK_COUNT=$1
  fi
  echo "TRACK_COUNT is $TRACK_COUNT"
}

function recordTrack {
    echo "recordTrack called FILENAME_PREFIX:$FILENAME_PREFIX URL: $URL" 
    icecream --name=$FILENAME_PREFIX%m-%d-%y-%H-%M-%S --stop=90mb $URL
}

function filterSmallFiles {
    find -name "*.mp3" -size -1024k -delete
}

function cutPrefixAds {
  FILES=`find . -maxdepth 1  -type f  -name "$FILENAME_PREFIX*.mp3" -printf '%f\n'`
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


printUsage
initTrackCount $1


mkdir $DIRNAME
cd $DIRNAME

COUNTER=0;
while [  $COUNTER -lt $TRACK_COUNT ]; do
    echo The counter is $COUNTER
    let COUNTER=COUNTER+1 
    recordTrack
done

filterSmallFiles
cutPrefixAds
exit