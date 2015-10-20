#!/bin/bash
##record 30 songs from internet radio

##sox psychedelik_amb_10-18-15-21-03-17.mp3 trm_psychedelik_amb_10-18-15-21-03-17.mp3 trim 5
##find . -maxdepth 1  -type f  -name "*.mp3" -printf '%f\n' -exec sox {} trm_{} trim 5 \;
function cutPrefixAds(){
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

cutPrefixAds
