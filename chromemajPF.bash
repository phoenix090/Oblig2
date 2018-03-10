#!/bin/bash


program=chrome

#fpid=$(ps aux | grep -i firefox | awk {'print $2'})
array=($(pgrep -x chrome))

for i in ${array[*]}; do

  antall=$(ps --no-headers -o maj_flt $i)
  if [ $antall -gt 1000 ]; then
	   echo "$program $i har forårsaket $antall pagefaults (mer enn 1000!)"
  else
	   echo "$program $i har forårsaket $antall"
  fi
done
