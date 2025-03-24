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
if [ -z "$3" ]; then
   exit
fi


        sudo sed -i '/^\[/h;G;/Profile1/s/\(priority=\).*/\1'"$1"'/m;P;d' $dirn
        sudo sed -i '/^\[/h;G;/Profile2/s/\(priority=\).*/\1'"$2"'/m;P;d' $dirn
        sudo sed -i '/^\[/h;G;/Profile3/s/\(priority=\).*/\1'"$3"'/m;P;d' $dirn
        sudo sed -i '/^\[/h;G;/Profile4/s/\(priority=\).*/\1'"$4"'/m;P;d' $dirn
        sudo sed -i '/^\[/h;G;/Profile5/s/\(priority=\).*/\1'"$5"'/m;P;d' $dirn






