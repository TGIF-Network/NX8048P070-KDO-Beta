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
if [ -z "$1" ]; then
   exit
fi

	sudo sed -i '/^\[/h;G;/Profile'"$1"'/s/\(ssid=\).*/\1'"$2"'/m;P;d' $dirn     
	sudo sed -i '/^\[/h;G;/Profile'"$1"'/s/\(password=\).*/\1'"$3"'/m;P;d' $dirn     




