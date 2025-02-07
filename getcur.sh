#!/bin/bash
#################################################
#  Get Last Heard Liost from MMDVMHost Log	#
#						#
#						#
#  VE3RD 			2020-05-03	#
#################################################
set -o errexit
set -o pipefail

######################################
#Start of Main Program
######################################


#M: 2025-02-03 17:21:36.810 DMR Slot 2, received network voice header from AD2CH to TG 14031665
#M: 2025-02-03 17:21:40.118 DMR Slot 2, received network end of voice transmission from AD2CH to TG 14031665, 3.4 seconds, 0% packet loss, BER: 0.0%
#M: 2025-02-03 17:22:00.871 DMR Slot 2, received RF voice header from VE3RD to TG 14031665
#1                                          7    8    9    10     11   12   13 14   15
#M: 2025-02-03 17:22:01.279 DMR Slot 2, received RF end of voice transmission from VE3RD to TG 14031665, 0.4 seconds, BER: 0.0%, RSSI: -47/-47/-47 dBm
#M: 2025-02-03 17:22:35.041 DMR Slot 2, received network voice header from VE3RIX to TG 14031665
#M: 2025-02-03 17:22:35.867 DMR Slot 2, received network end of voice transmission from VE3RIX to TG 14031665, 1.2 seconds, 0% packet loss, BER: 0.0%
#1   2            3          4   5   6     7       8      9  10  11      12         13    14   15 16    17     18   19      20   21    22   23   24   

f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
#list1=$(sudo sed -n '/received network/p' $f1 | sed 's/,//g' | tail -1)
list1=$(sudo sed -n '/DMR Slot 2, received/p' $f1 | tail -1)
netrf=$(echo "$list1" | cut -d " " -f8 )
hdrend=$(echo "$list1" | cut -d " " -f9 )

#echo "$list1"
#echo "$netrf|1"
#echo "$hdrend|1"

if [ "$netrf" == "RF" ]; then
	if [ "$hdrend" == "end" ]; then
  		call=$(echo "$list1" | cut -d " " -f14 )
  		tg=$(echo "$list1" | cut -d " " -f17 )
		ve="E"
		BER=$(echo "$list1" | cut -d " " -f21)

	fi
	if [ "$hdrend" == "voice" ]; then
  		call=$(echo "$list1" | cut -d " " -f12 )
  		tg=$(echo "$list1" | cut -d " " -f15 )
		ve="V"
		BER="na"
	fi
	mode="R"
fi

if [ "$netrf" == "network" ]; then
	if [ "$hdrend" == "end" ]; then
  		call=$(echo "$list1" | cut -d " " -f14 )
		ve="E"
        	tg=$(echo "$list1" | cut -d " " -f17)
        	pl=$(echo "$list1" | cut -d " " -f20)
	fi
	if [ "$hdrend" == "voice" ]; then
  		call=$(echo "$list1" | cut -d " " -f12 )
		ve="V"
        	tg=$(echo "$list1" | cut -d " " -f15)
		pl=0
	fi
	mode="N"

fi

if [ "$hdrend" == "end" ]; then
        echo "X|X|Listen|Listen|Listen|na|na|na"
else


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
#        echo "$dt|$tm|$mode|$call|$name|$city, $prov, $country|$tg|$pl|$BER"
        echo "$mode|$ve|$call|$name|$city, $prov, $country|$tg|$pl|$BER"
fi	
#	domodedmr

sudo mount -o remount,ro /

