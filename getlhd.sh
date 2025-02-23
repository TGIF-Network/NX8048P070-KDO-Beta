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
function domodedmr
{
line3=""
	list1=$(sudo sed -n '/end of voice transmission from/p' $f1 | sed 's/,//g' | tail -1)

	call=$(echo "$list1" | cut -d " " -f14)
	echo "Add Call: $call" >> /home/pi-star/lh2_start.txt
	dataline=$(sudo sed -n "/$call,/p" /usr/local/etc/stripped.csv)
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


function nolhd
{
 	echo "na|na|na|Heard|Data|Available|No Last"
	exit
}

##################################################

######################################
#Start of Main Program
######################################

f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
#list1=$(sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | tail -1)
list1=$(sudo sed -n '/transmission from/p' $f1 | tail -1)
#echo "$list1"

if [ -z "$list1" ]; then
   nolhd
fi

#mode=$(echo "${list1:27:8}" |sed 's/,//g' | cut -d " " -f1)
mode=$(echo "$list1" | cut -d " " -f4 | sed 's/,//g' )
dt=$(echo "$list1" | cut -d " " -f2 )
tm1=$(echo "$list1" | cut -d " " -f3 | cut -d "." -f1)
#echo "$mode"
tm=$(date -d "${tm1:0:-1} UTC" '+%R')


if [ "$mode" == "DMR" ]; then

        list1=$(sudo sed -n '/end of voice transmission from/p' $f1 | sed 's/,//g' | tail -1)
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

	rfnet=$(echo "$list1" | cut -d " " -f8)

#M: 2025-02-20 00:20:56.125 DMR Slot 2, received network end of voice transmission from VE3RD to TG 14031665, 0.5 seconds, 0% packet loss, BER: 0.0%

	if [ "$rfnet" == "network" ]; then

        	tg=$(echo "$list1" | cut -d " " -f17)
        	pl=$(echo "$list1" | cut -d " " -f20)
        	name="$n1"
		rx=$(echo "$list1" | cut -d " " -f8)
		BER=$(echo "$list1" | cut -d " " -f24)
	fi
#M: 2025-02-20 00:25:13.268 DMR Slot 2, received RF end of voice transmission from VE3RD to TG 14030200, 9.0 seconds, BER: 0.7%, RSSI: -47/-47/-47 dBm

	if [ "$rfnet" == "RF" ]; then
        	tg=$(echo "$list1" | cut -d " " -f17)
        	name="$n1"
		rx=$(echo "$list1" | cut -d " " -f8)
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
#M: 2025-02-22 20:03:46.111 D-Star, received network header from K4WZV   /     to CQCQCQ   via REF066 D

if [ "$mode" == "D-Star" ]; then
	list1=$(sudo sed -n '/received network end of transmission from/p' $f1 | sed 's/,//g' | tail -1)
	call=$(echo "$list1" | cut -d " " -f11)
	pl=$(echo "$list1" | cut -d " " -f19)

	list2=$(sudo sed -n '/received network header from/p' $f1 | sed 's/,//g' | tail -1)
	tg2=$(echo "$list2" | cut -d " " -f19)
	tg1=$(echo "$list2" | cut -d " " -f20)
	tg="$tg2 $tg1"
	echo "$tg"
#M: 2025-02-22 21:35:22.036 D-Star link status set to "Linked to REF066 D  "
	list3=$(sudo sed -n '/D-Star link status set to/p' $f1 | sed 's/,//g' | sed 's/"//g' | tail -1 | tr '  ' ' ')
echo "$list3"
	tg2=$(echo "$list3" | cut -d " " -f11)
	tg1=$(echo "$list3" | cut -d " " -f12)
	tg="$tg2 $tg1"
	echo "$tg"



#	echo "$mode: $Call"
	domodedstar
fi

if [ "$mode" == "YSF" ]; then
        list1=$(sudo sed -n '/received network end of transmission from/p' $f1 | sed 's/,//g' | tail -1 | tr -d ',')
        call=$(echo "$list1" | cut -d " " -f11)
	pl=$(echo "$list1" | cut -d " " -f22)
#        echo "$mode: $Call"
         tg1=$(echo "$list1" | cut -d " " -f17)
         tg2=$(echo "$list1" | cut -d " " -f18)
	tg="$tg1 $tg2"
	domodedysf
fi
if [ "$mode" == "NXDN" ]; then
        list1=$(sudo sed -n '/received network end of transmission from/p' $f1 | sed 's/,//g' | tail -1 | tr -d ',')
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


