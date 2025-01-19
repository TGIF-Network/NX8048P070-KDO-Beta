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
function domodedmr
{
line3=""
	list1=$(sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | tail -1)

	call=$(echo "$list1" | cut -d " " -f14)
	echo "Add Call: $call" >> /home/pi-star/lh2_start.txt
	dataline=$(sudo sed -n "/$call/p" /usr/local/etc/stripped.csv)
       	did=$(echo "$dataline" | cut -d',' -f1 | head -1)
        n1=$(echo "$dataline" | cut -d',' -f3 | head -1)
        n2=$(echo "$dataline" | cut -d',' -f4 | head -1)
        city=$(echo "$dataline" | cut -d',' -f5 | head -1)
        prov=$(echo "$dataline" | cut -d',' -f6 | head -1)
        country=$(echo "$dataline" | cut -d',' -f7 | head -1)
	tg=$(echo "$list1" | cut -d " " -f17)
	pl=$(echo "$list1" | cut -d " " -f20)
      name="$n1"

if [ -z "$city" ]; then
	city="N/A"
fi
	echo "$dt|$tm|$mode|$call|$name|$city, $prov, $country|$tg|$pl" 
#| tr -d "\n" 
}

function domodedstar
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
      name="$n1"

if [ -z "$city" ]; then
        city="N/A"
fi
        echo "$dt|$tm|$mode|$call|$name|$city, $prov, $country|$tg|$pl"
#| tr -d "\n"
}

function domodedysf
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
      name="$n1"

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
#list1=$(sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | tail -1)
list1=$(sudo sed -n '/transmission from/p' $f1 | tail -1)
#echo "$list1"

#mode=$(echo "${list1:27:8}" |sed 's/,//g' | cut -d " " -f1)
mode=$(echo "$list1" | cut -d " " -f4 | sed 's/,//g' )
dt=$(echo "$list1" | cut -d " " -f2 )
tm1=$(echo "$list1" | cut -d " " -f3 | cut -d "." -f1)
#echo "$mode"
tm=$(date -d "${tm1:0:-1} UTC" '+%R')

if [ "$mode" == "DMR" ]; then
        list1=$(sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | tail -1)
	tm1=$(echo "${list1:3:19}")
#	echo "$tm1"
#	echo "$tm"

        call=$(echo "$list1" | cut -d " " -f14)
        echo "Add Call: $call" >> /home/pi-star/lh2_start.txt
        dataline=$(sudo sed -n "/$call/p" /usr/local/etc/stripped.csv)
        did=$(echo "$dataline" | cut -d',' -f1 | head -1)
        n1=$(echo "$dataline" | cut -d',' -f3 | head -1)
        n2=$(echo "$dataline" | cut -d',' -f4 | head -1)
        city=$(echo "$dataline" | cut -d',' -f5 | head -1)
        prov=$(echo "$dataline" | cut -d',' -f6 | head -1)
        country=$(echo "$dataline" | cut -d',' -f7 | head -1)
        tg=$(echo "$list1" | cut -d " " -f17)
        pl=$(echo "$list1" | cut -d " " -f20)
        name="$n1"
	BER=$(echo "$list1" | cut -d " " -f24)
	rx=$(echo "$list1" | cut -d " " -f8)
	if [ "$rx" == "$RF" ]; then
		pl="N/A"
		BER=$(echo "$list1" | cut -d " " -f21)
	fi

#M: 2025-01-17 23:19:06.311 DMR Slot 2, received RF end of voice transmission from VE3RD to TG 14031665, 1.1 seconds, BER: 0.4%, RSSI: -47/-47/-47 dBm
#M: 2025-01-17 23:19:35.377 DMR Slot 2, received network end of voice transmission from VE3RD to TG 14031665, 0.5 seconds, 0% packet loss, BER: 0.0%


	if [ -z "$city" ]; then
        	city="N/A"
	fi
        echo "$dt|$tm|$mode|$call|$name|$city, $prov, $country|$tg|$pl|$BER"
	
#	domodedmr
fi
if [ "$mode" == "D-Star" ]; then
	list1=$(sudo sed -n '/received network end of transmission from/p' $f1 | sed 's/,//g' | tail -1)
	call=$(echo "$list1" | cut -d " " -f11)
	pl=$(echo "$list1" | cut -d " " -f19)

	list2=$(sudo sed -n '/end of transmission/p' $f1 | sed 's/,//g' | tail -1)
	tg2=$(echo "$list2" | cut -d " " -f15)
	tg1=$(echo "$list2" | cut -d " " -f14)
	tg="$tg2 $tg1"

#	echo "$mode: $Call"
	domodedstar
fi

if [ "$mode" == "YSF" ]; then
        list1=$(sudo sed -n '/received network end of transmission from/p' $f1 | sed 's/,//g' | tail -1)
        call=$(echo "$list1" | cut -d " " -f11)
	pl=$(echo "$list1" | cut -d " " -f22)
#        echo "$mode: $Call"
         tg1=$(echo "$list1" | cut -d " " -f17)
         tg2=$(echo "$list1" | cut -d " " -f18)
	tg="$tg1 $tg2"
	domodedysf
fi
if [ "$mode" == "NXDN" ]; then
        list1=$(sudo sed -n '/received network end of transmission from/p' $f1 | sed 's/,//g' | tail -1)
        call=$(echo "$list1" | cut -d " " -f11)
        pl=$(echo "$list1" | cut -d " " -f19)
#        echo "$mode: $Call"
        domodedysf
fi
if [ "$mode" == "M17" ]; then
        list1=$(sudo sed -n '/received network end of transmission from/p' $f1 | sed 's/,//g' | tail -1)
        call=$(echo "$list1" | cut -d " " -f11)
        pl=$(echo "$list1" | cut -d " " -f19)
#        echo "$mode: $Call"
        domodedysf
fi

sudo mount -o remount,ro /

