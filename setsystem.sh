#!/bin/bash
############################################################
#  Activate  Profile                                       #
#  VE3RD                                      2019/11/18   #
############################################################
set -o errexit
set -o pipefail


set -o errexit
set -o pipefail
ver="20250204"
dirn=/etc/profiles.ini
declare -i pnum

if [ -z "$1" ]; then
        exit
fi
args=("$@")
p0=${args[0]}
p1=${args[1]}
p2=${args[2]}
p3=${args[3]}
p4=${args[4]}
p5=${args[5]}
p6=${args[6]}
p7=${args[7]}
p8=${args[8]}
p9=${args[9]}
#echo "$p0 $p1 $p2 $p3 $p4 $p5 $p6 $p7 $p8 $p9" 
sudo mount -o remount,rw /

                sudo sed -i '/^\[/h;G;/Modem/s/\(^RXOffset=\).*/\1'"$p0"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/Modem/s/\(^TXOffset=\).*/\1'"$p1"'/m;P;d' /etc/mmdvmhost

                sudo sed -i '/^\[/h;G;/Info/s/\(^RXFrequency=\).*/\1'"$p2"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/Info/s/\(^TXFrequency=\).*/\1'"$p3"'/m;P;d' /etc/mmdvmhost

                sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$p4"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/General/s/\(^Callsign=\).*/\1'"$p5"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/General/s/\(^Duplex=\).*/\1'"$p6"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/NextionDriver/s/\(^LogLevel=\).*/\1'"$p7"'/m;P;d' /etc/mmdvmhost

                sudo sed -i '/^\[/h;G;/NextionDriver/s/\(^WaitForLan=\).*/\1'"$p8"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/NextionDriver/s/\(^SleepWhenInactive=\).*/\1'"$p9"'/m;P;d' /etc/mmdvmhost



 sudo mmdvmhost.service restart
sudo nextiondriver.service restart
sudo mount -o remount,ro /

