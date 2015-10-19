#!/bin/bash
##record 30 songs from internet radio

DIRNAME=cast_`date +%m-%d-%y`
mkdir $DIRNAME
cd $DIRNAME

function recordTrack {
    echo "recordTrack called" 
    icecream --name=psychedelik_amb_%m-%d-%y-%H-%M-%S --stop=2songs http://195.154.86.144:8002/relay.mp3?icy=http
}

function filterSmallFiles {
    find -name "*.mp3" -size -1024k -delete
}

COUNTER=0
while [  $COUNTER -lt 150 ]; do
    echo The counter is $COUNTER
    let COUNTER=COUNTER+1 
    recordTrack
done

filterSmallFiles
exit