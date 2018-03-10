#!/bin/bash

program=chrome

while read ans
 do
 	mjfault=$(ps --no-headers -o maj_flt "$ans")

 	if [ "$mjfault" -gt 1000 ]
 		then
 			echo "$program $ans har forårsaket $majflt page faults (mer enn 1000!)"
 	else
 		 	echo "$program $ans har forårsaket $majflt page faults"
	fi
done < <(pgrep $program)
