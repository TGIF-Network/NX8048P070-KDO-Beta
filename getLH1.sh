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

if [ -f /home/pi-star/lh2_start.txt ]; then
  rm /home/pi-star/lh2_start.txt
fi
if [ -f /home/pi-star/lhlog.txt ]; then
  rm /home/pi-star/lhlog.txt
fi

echo "Args = $@" >> /home/pi-star/lh2_start.txt

name=""
pl=""

declare -i n
####################################################
##########################################################
function domode3
{
line3=""
	echo "Add Call: $call" >> /home/pi-star/lh2_start.txt
	dataline=$(sudo sed -n "/$call/p" /usr/local/etc/stripped.csv)
       	did=$(echo "$dataline" | cut -d',' -f1 | head -1)
        n1=$(echo "$dataline" | cut -d',' -f3 | head -1)
        n2=$(echo "$dataline" | cut -d',' -f4 | head -1)
        city=$(echo "$dataline" | cut -d',' -f5 | head -1)
        prov=$(echo "$dataline" | cut -d',' -f6 | head -1)
        country=$(echo "$dataline" | cut -d',' -f7 | head -1)
      name="$n1 $n2"

if [ -z "$city" ]; then
	city="N/A"
fi
	echo "$dt|$tm|$mode|$call|$name|$city, $prov, $country|$tg|$pl" 
#| tr -d "\n" 
}
##################################################

######################################
#Start of Main Program
######################################

f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
list1=$(sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | tail -1)
dt=$(echo "$list1" | cut -d " " -f2)
tm=$(echo "$list1" | cut -d " " -f3)
tm="${tm:0:8}"
mode=$(echo "$list1" | cut -d " " -f4)
call=$(echo "$list1" | cut -d " " -f14)
tg=$(echo "$list1" | cut -d " " -f17)
pl=$(echo "$list1" | cut -d " " -f20)
#echo "$dt :: $tm :: $mode :: $call"


	domode3

sudo mount -o remount,ro /
