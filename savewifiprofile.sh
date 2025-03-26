#!/bin/bash
############################################################
#  Set WiFi Profile                                        #
#  VE3RD                                      2025-03-14   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

#echo "Save to Profile"
args=("$@")

dirn=/etc/wifiprofiles.ini

#if [ -z "$3" ]; then
#   exit
#fi

#printf "$2|$3|$4\n" > /home/pi-star/wifitest.txt


essid=$(echo "$2" | tr -d '"')
password=$(echo "$3" | tr -d '"')
priority=$(echo "$4" | tr -d '"')
n0="$1"
n4="$4"

if [ -z "$4" ]; then
	pri=$(echo $(( ( 10 - n0 ) * 10 + n0 )))
#	echo "$pri"
else
	pri=$(echo $(( n4 )))
#	echo "$pri"
fi
#printf "$2|$3|$4|None\n" >> /home/pi-star/wifitest.txt

#printf "$essid|$password|$pri|None\n" >> /home/pi-star/wifitest.txt

	sudo sed -i '/^\[/h;G;/Profile'"$1"'/s/\(ssid=\).*/\1'"$essid"'/m;P;d' $dirn     
	sudo sed -i '/^\[/h;G;/Profile'"$1"'/s/\(password=\).*/\1'"$password"'/m;P;d' $dirn     
	sudo sed -i '/^\[/h;G;/Profile'"$1"'/s/\(priority=\).*/\1'"$pri"'/m;P;d' $dirn     
	sudo sed -i '/^\[/h;G;/Profile'"$1"'/s/\(id_str=\).*/\1None/m;P;d' $dirn     

#printf "$essid|$password|$pri|None\n" >> /home/pi-star/wifitest.txt




