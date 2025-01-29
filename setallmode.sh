#!/bin/bash
############################################################
#  Change Mode in /etc/mmdvmhost                           #
#  $1 1-6 Select Mode to change  $2 enable= 0 or 1         #
#  Also enable corresponding network                       #
#  KF6S                                        09-14-2019  #
############################################################
set -o errexit
set -o pipefail
# Check all six modes and set each one to either 0 or 1

sudo mount -o remount,rw /
#DMR
#D-Star
#YSF
#P25
#NXDN
#POCSAG
#M17

		sudo sed -i '/^\[/h;G;/DMR/s/\(^Enable=\).*/\1'"$2"'/m;P;d' /etc/mmdvmhost
		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Enable=\).*/\1'"$2"'/m;P;d' /etc/mmdvmhost

		sudo sed -i '/^\[/h;G;/D-Star/s/\(^Enable=\).*/\1'"$1"'/m;P;d' /etc/mmdvmhost
		sudo sed -i '/^\[/h;G;/D-Star Network/s/\(^Enable=\).*/\1'"$1"'/m;P;d' /etc/mmdvmhost

		sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\1'"$3"'/m;P;d' /etc/mmdvmhost
		sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\1'"$3"'/m;P;d' /etc/mmdvmhost

		sudo sed -i '/^\[/h;G;/P25/s/\(^Enable=\).*/\1'"$4"'/m;P;d' /etc/mmdvmhost
		sudo sed -i '/^\[/h;G;/P25 Network/s/\(^Enable=\).*/\1'"$4"'/m;P;d' /etc/mmdvmhost

		sudo sed -i '/^\[/h;G;/NXDN/s/\(^Enable=\).*/\1'"$5"'/m;P;d' /etc/mmdvmhost
		sudo sed -i '/^\[/h;G;/NXDN Network/s/\(^Enable=\).*/\1'"$5"'/m;P;d' /etc/mmdvmhost

		sudo sed -i '/^\[/h;G;/POCSAG/s/\(^Enable=\).*/\1'"$6"'/m;P;d' /etc/mmdvmhost
		sudo sed -i '/^\[/h;G;/POCSAG Network/s/\(^Enable=\).*/\1'"$6"'/m;P;d' /etc/mmdvmhost

		sudo sed -i '/^\[/h;G;/M17/s/\(^Enable=\).*/\1'"$7"'/m;P;d' /etc/mmdvmhost
		sudo sed -i '/^\[/h;G;/M17 Network/s/\(^Enable=\).*/\1'"$7"'/m;P;d' /etc/mmdvmhost



 sudo mmdvmhost.service restart
sudo mount -o remount,ro /

