#!/bin/bash
############################################################
#  Set Profile                                       #
#  VE3RD                                      2019/10/28   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Save to Profile"
args=("$@")


dirn=/etc/profiles.ini
if [ -z "$1" ]; then
   exit
else
    if [ -z "$2" ]; then
          exit
    fi
fi

if [ "$1" == "A" ]; then
	sudo sed -i '/^\[/h;G;/Profile '"$2"'/s/\(RXOffset=\).*/\1'"$3"'/m;P;d' $dirn     
	sudo sed -i '/^\[/h;G;/Profile '"$2"'/s/\(TXOffset=\).*/\1'"$4"'/m;P;d' $dirn     
	sudo sed -i '/^\[/h;G;/Profile '"$2"'/s/\(RXFrequency=\).*/\1'"$5"'/m;P;d' $dirn     
	sudo sed -i '/^\[/h;G;/Profile '"$2"'/s/\(TXFrequency=\).*/\1'"$6"'/m;P;d' $dirn     
	sudo sed -i '/^\[/h;G;/Profile '"$2"'/s/\(Password=\).*/\1'"$7"'/m;P;d' $dirn     

fi


if [ "$1" == "B" ]; then
	sudo sed -i '/^\[/h;G;/Profile '"$2"'/s/\(Address=\).*/\1'"$3"'/m;P;d' $dirn     
	sudo sed -i '/^\[/h;G;/Profile '"$2"'/s/\(WhiteList=\).*/\1'"$4"'/m;P;d' $dirn     
	sudo sed -i '/^\[/h;G;/Profile '"$2"'/s/\(Name=\).*/\1'"$5"'/m;P;d' $dirn     
fi

