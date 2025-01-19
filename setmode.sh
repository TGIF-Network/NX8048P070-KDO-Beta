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

if [ -z "$2" ]; then
        exit
  else
sudo mount -o remount,rw /


        if [ "$1" = "0" ]; then 
		sudo sed -i '/\[D-Star\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
                sudo sed -i '/\[D-Star Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
        fi

        if [ "$2" = "0" ]; then 
		sudo sed -i '/\[DMR\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
               sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
        fi

        if [ "$3" = "0" ]; then 
#		sudo sed -i '/\[System Fusion\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
 #               sudo sed -i '/\[System Fusion Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
		sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\1'"0"'/m;P;d' /etc/mmdvmhost
		sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\1'"0"'/m;P;d' /etc/mmdvmhost
        fi

        if [ "$4" = "0" ]; then 
		sudo sed -i '/\[P25\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
                              sudo sed -i '/\[P25 Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
        fi

        if [ "$5" = "0" ]; then 
		sudo sed -i '/\[NXDN\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
                              sudo sed -i '/\[NXDN Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
        fi

        if [ "$6" = "0" ]; then 
		sudo sed -i '/\[POCSAG\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
                              sudo sed -i '/\[POCSAG Network\]/!b;n;cEnable='"0"'' /etc/mmdvmhost
        fi
        if [ "$1" = "1" ]; then 
		sudo sed -i '/\[D-Star\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                              sudo sed -i '/\[D-Star Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
        fi

        if [ "$2" = "1" ]; then 
		sudo sed -i '/\[DMR\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                              sudo sed -i '/\[DMR Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
        fi

        if [ "$3" = "1" ]; then 
		sudo sed -i '/^\[/h;G;/System Fusion/s/\(^Enable=\).*/\1'"1"'/m;P;d' /etc/mmdvmhost
		sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(^Enable=\).*/\1'"1"'/m;P;d' /etc/mmdvmhost

#		sudo sed -i '/\[System Fusion\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
#                sudo sed -i '/\[System Fusion Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
        fi

        if [ "$4" = "1" ]; then 
		sudo sed -i '/\[P25\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                              sudo sed -i '/\[P25 Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
        fi

        if [ "$5" = "1" ]; then 
		sudo sed -i '/\[NXDN\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                              sudo sed -i '/\[NXDN Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
        fi

        if [ "$6" = "1" ]; then 
		sudo sed -i '/\[POCSAG\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
                              sudo sed -i '/\[POCSAG Network\]/!b;n;cEnable='"1"'' /etc/mmdvmhost
        fi
 sudo mmdvmhost.service restart
sudo mount -o remount,ro /

fi;
