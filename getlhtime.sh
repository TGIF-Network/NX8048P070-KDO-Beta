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

#if [ -f /home/pi-star/lh2_start.txt ]; then
# rm /home/pi-star/lh2_start.txt
#fi

if [ -f /home/pi-starlhlog.txt ]; then
  rm /home/pi-star/lhlog.txt
fi

echo "Args = $@" > /home/pi-star/lh2_start.txt

name=""
pl=""

declare -i n
####################################################
##########################################################

######################################
#Start of Main Program
######################################

f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
#list1=$(sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | tail -1)
list1=$(sudo sed -n '/from/p' $f1 | tail -1)
#echo "$list1"

#mode=$(echo "${list1:27:8}" |sed 's/,//g' | cut -d " " -f1)
mode=$(echo "$list1" | cut -d " " -f4 | sed 's/,//g' )
dt=$(echo "$list1" | cut -d " " -f2 )
tm1=$(echo "$list1" | cut -d " " -f3 | cut -d "." -f1)
#echo "$mode"
tm=$(date -d "${tm1:0:-1} UTC" '+%R')

echo "$tm|$mode"


