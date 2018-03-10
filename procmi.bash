#!/bin/bash

VmSize="Total bruk av virtuelt minne (VmSize):"
VmDSE="Mende privat virtuelt minne (VmData-VmStk+VmExe):"
VmLib="Mengde shared virtuelt minne (VmLib):"
VmRSS="Total bruk av fysisk minne (VmRSS):"
VmPTE="Mengde fysisk minne som benyttes til page table (VmPTE):"


for pid in "$@"
do
echo "******** Minne info om prosess med PID $pid *********" >> PID-dato.meminfo
echo "$VmSize" $(grep VmSize /proc/$pid/status | awk '{print $2,$3}') >> PID-dato.meminfo
VmData=$(grep VmData /proc/$pid/status | awk '{print $2}')
VmStk=$(grep VmStk /proc/$pid/status | awk '{print $2}')
VmExe=$(grep VmExe /proc/$pid/status | awk '{print $2}')
echo "$VmDSE" $((VmData+VmStk+VmExe)) "kB" >> PID-dato.meminfo

echo "$VmLib" $(grep VmLib /proc/$pid/status | awk '{print $2,$3}') >> PID-dato.meminfo
echo "$VmRSS" $(grep VmRSS /proc/$pid/status | awk '{print $2,$3}') >> PID-dato.meminfo
echo "$VmPTE" $(grep VmPTE /proc/$pid/status | awk '{print $2,$3}') >> PID-dato.meminfo
echo >> PID-dato.meminfo

done
