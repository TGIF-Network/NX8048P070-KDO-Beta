#!/bin/bash
#################################################
#  Get Last Heard Liost from MMDVMHost Log	#
#						#
#						#
#  VE3RD 			2020-05-03	#
#################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /


function nolhd
{
 	echo "na|na|na|Heard|Data|Available|No Last"
	exit
}

##################################################

######################################
#Start of Main Program
######################################
#M: 2025-02-22 22:00:00.579 D-Star, received network header from VE3RD   /TIME to CQCQCQ   via REF066 D

f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
list1=$(sudo sed -n '/Linked/p' $f1 | tail -1 | tr -d '"')
list2=$(sudo sed -n '/via/p' $f1 | tail -1 | tr '  ' ' ')

#echo "$list1"
#echo "$list2"
mode=$(echo "$list1" | cut -d " " -f4)
#echo "$mode"

if [ "$mode" == "D-Star" ]; then
   tg=$(echo "$list2" | cut -d " " -f18,19)
   if [ -z "$tg" ]; then
   	tg=$(echo "$list1" | cut -d " " -f11,12)
   	if [ -z "$tg" ]; then
		tg="Not Found"
		echo "$tg"
	fi
   else
   	echo "$tg"
   fi

fi


