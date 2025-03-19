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

mode=$(echo "$list1" | cut -d " " -f4)
	#echo "$mode"

ref=$(sed -n '/.*via/{s///;p;}' /var/log/pi-star/MMDVM* |tail -n1 | sed 's/^[[:space:]]*//') 


if [ "$mode" == "D-Star" ]; then
   echo "$ref"
fi
#echo "$mode"
