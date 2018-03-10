#!/bin/bash

### Funksjoner:
function meny(){

	echo "1 - Hvem er jeg og hva er navnet på dette skripte?"
	echo "2 - Hvor lenge er det siden siste boot?"
	echo "3 - Hvor mange prosesser og tråder finnes?"
	echo "4 - Hvor mange context switch'er fant sted siste sekund?"
	echo "5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode
og i usermode siste sekund?"
	echo "6 - Hvor mange interrupts fant sted siste sekund?"
	echo "9 - Avslutt dette scriptet"
}

### Henter antall context-switch det siste sekundet ###
function contextswitch {
	switch1=$(grep ctxt /proc/stat | awk '{print $2}')
	sleep 1
	switch2=$(grep ctxt /proc/stat | awk '{print $2}')
	echo $((switch2-switch1))
	echo
}

### Henter antall interrupts det siste sekundet ###
function interrupts {
	int1=$(grep intr /proc/stat | awk '{print $2}')
	sleep 1
	int2=$(grep intr /proc/stat | awk '{print $2}')
	echo $((int2-int1))
	echo
}

### Henter hvor av CPU-en brukt til user/kernelmode det siste sekundet ###
function cpuTid {
	usermode1=$(grep -m 1 cpu /proc/stat | awk '{print $2}')
	kernelmode1=$(grep -m 1 cpu /proc/stat | awk '{print $4}')
	sleep 1
	usermode2=$(grep -m 1 cpu /proc/stat | awk '{print $2}')
	kernelmode2=$(grep -m 1 cpu /proc/stat | awk '{print $4}')

	user=$((usermode2-usermode1))
	kernel=$((kernelmode2-kernelmode1))

	sum=$((user + kernel))

	prosent=$((100 / sum))

	echo "$((user*prosent)) % av CPU-en til har gått til usermode det siste sekundet"
	echo "$((kernel*prosent)) % av CPU-en til har gått til kernelmode det siste sekundet"
	echo
}

### Main ###
while true
do

	meny
	echo -e "\n"

	read -r ans
	case $ans in
	1) echo -e "\nJeg er $(whoami), og du kjører $0\n";;
	2) echo -e "\nDet er $(uptime | awk '{print $3}') time siden siste boot\n";;
	3) echo -e "\n Antall Prosesser&tråder: $(ps auxh -T | wc -l) \n" ;;
	4) 	contextswitch ;;
	5)  cpuTid ;;
	6)  interrupts ;;
	9) echo -e "\nAvslutter..\n"
	 break;
	 ;;
	*) echo -e "\nDu har valgt ugyldig nr, $ans \n";;
	esac
done
