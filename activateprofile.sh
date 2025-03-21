#!/bin/bash
############################################################
#  Activate  Profile                                       #
#  VE3RD                                      2019/11/18   #
############################################################
set -o errexit
set -o pipefail
ver="20250204"
dirn=/etc/profiles.ini
declare -i pnum
args=("$@")

sudo mount -o remount,rw /
systemctl stop mmdvmhost


echo "Activate Profile Log" > /home/pi-star/activate.log
echo "$args" >> /home/pi-star/activate.log


if [ -z "$1" ]; then
        exit
fi

ref=$(cat /etc/ircddbgateway |grep reflector1 |cut -d '=' -f2)
        id=$(sed -nr "/^\[General\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)

	pnum=$(echo $1 | sed 's/^0*//')
	#pnum="$1"
#        echo "$pnum"
        m0=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
        m1=$(sed -nr "/^\[Profile $pnum\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
        m2=$(sed -nr "/^\[Profile $pnum\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
        m3=$(sed -nr "/^\[Profile $pnum\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
        m4=$(sed -nr "/^\[Profile $pnum\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
        m5=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
        m6=$(sed -nr "/^\[Profile $pnum\]/ { :l /^WhiteList[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
        m7=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
# m6 9 digit ID	
# m6a 7 digit ID
#	echo "1 $id"
        id2="$id""01"
#	echo "1 $id2"
	id3=${id2:0:7}
 #       echo "3 $id3"

	 echo "$m0|$m1|$m2|$m3|$m4|$m5|$m6|$m7" >> /home/pi-star/activate.log
	sudo mount -o remount,rw /

        sudo sed -i '/^\[/h;G;/DMR\]/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost

        sudo sed -i '/^\[/h;G;/DMR Netwqork/s/\(^Name=\).*/\1'"$m0"'/m;P;d' /etc/mmdvmhost

        sudo sed -i '/^\[/h;G;/Modem/s/\(^RXOffset=\).*/\1'"$m1"'/m;P;d' /etc/mmdvmhost
        sudo sed -i '/^\[/h;G;/Modem/s/\(^TXOffset=\).*/\1'"$m2"'/m;P;d' /etc/mmdvmhost

        sudo sed -i '/^\[/h;G;/Info/s/\(^RXFrequency=\).*/\1'"$m3"'/m;P;d' /etc/mmdvmhost
        sudo sed -i '/^\[/h;G;/Info/s/\(^TXFrequency=\).*/\1'"$m4"'/m;P;d' /etc/mmdvmhost

        sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1'"$m5"'/m;P;d' /etc/mmdvmhost
        sudo sed -i '/^\[/h;G;/DMR Network/s/\(^RemoteAddress=\).*/\1'"$m5"'/m;P;d' /etc/mmdvmhost

        sudo sed -i '/^\[/h;G;/DMR/s/\(^WhiteList=\).*/\1'"$m6"'/m;P;d' /etc/mmdvmhost
        sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"$m7"'/m;P;d' /etc/mmdvmhost
		if [ "$m5" == "127.0.0.1" ]; then
			sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Type=\).*/\1Gateway/m;P;d' /etc/mmdvmhost
			echo "Type=Gateway"
			sudo dmrgateway.service restart
		else	
			sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Type=\).*/\1Direct/m;P;d' /etc/mmdvmhost
			echo "Type=Direct"
		fi
        sudo sed -i '/^\[/h;G;/DMR\]/s/\(^Id=\).*/\1'"$id2"'/m;P;d' /etc/mmdvmhost
	

sleep 5
systemctl start mmdvmhost
sleep 2
sudo mount -o remount,ro /

