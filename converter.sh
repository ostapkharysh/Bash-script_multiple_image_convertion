#!/bin/bash

cd OpSys
declare count=0
declare indices=8

while getopts 'p:i:c:' opt; do #gives an ability to specify the path and the unique number starting point
  case $opt in
    p)
      echo "PATH: " $OPTARG
      cd
      cd $OPTARG
      echo " -p: Path chosen!" >&2
      ;;
    i)
      indices=$OPTARG
      echo " -i: Number of indices chosen!" >&2	
      ;;
    c)
      count=$OPTARG
      echo " -c: Starting number chosen!" >&2	
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

for image in *;
do
  today=`date '+%S_%M_%H-%d-%m-%Y'` #takes data of current time
  if [ ${image: -4} == ".jpg" ] || [ ${image: -5} == ".jpeg" ] || 
     [ ${image: -4} == ".bmp" ] || [ ${image: -4} == ".png" ] || [ ${image: -4} == ".gif" ];
     then
         j=`printf "%0*d" $indices $count` # creates startng uniqe number
         let count+=1 
         if [ ${image: -4} == ".gif" ] ;
             then
                 convert -strip $image[5] "${today%}-$j.jpg" #converts one picture from .gif
         else
             convert $image "${today%}-$j.jpg"
     #rm $image  # if removing image that was converted
         fi
  fi		
done
