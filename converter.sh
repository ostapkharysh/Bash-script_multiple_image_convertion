#!/bin/bash

#the default path is place where the file placed
declare count=0
declare indices=8

while getopts 'p:i:c:' opt; do #gives an ability to specify the path, the unique number and the starting point
  case $opt in
    p)
      echo "PATH: " $OPTARG #
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
  if [ "${image: -4}" == ".jpg" ] || [ "${image: -5}" == ".jpeg" ] || 
     [ "${image: -4}" == ".bmp" ] || [ "${image: -4}" == ".png" ] || [ "${image: -4}" == ".gif" ];
     then
         j=`printf "%0*d" $indices $count` # creates starting uniqe number
         let count+=1 
         if [ ${image: -4} == ".gif" ] ;
             then
                 convert -strip $image[0] "${today%}-$j.jpg" #converts one picture from .gif
         else
             convert $image "${today%}-$j.jpg"
         fi
     rm $image  # removing image that was under converting
  fi		
