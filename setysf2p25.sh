#!/bin/bash
############################################################
#  Set YSF2P25 Parameters                                  #
#							   #
#  Enable "$1" = 1 Sets YSF2P25 Mode			   #
#  Enable "$1" = 0 Clears YSF2P25 Mode & Sets DMR Master   #
#							   #
#  VE3RD                                      2020-01-27   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
m1=$(sed -nr "/^\[General\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)

echo "$1|$2|$3|$4|$5|$6|$7" > /home/pi-star/ysf2p25.txt

if [ -z "$1" ]; then
    echo "Insufficient Number of Parameters"
    exit
else
	# If Enabled
        if [ "$1" = 1 ]; then
#		sudo /usr/local/sbin/mmdvmhost.service stop  > /dev/null
		sudo /usr/local/etc/Nextion_Support/clearallmodes.sh

		p1="$1" # Enable
		p2="$2" # P25 TG 10210
##		p3="$3" # P25 Address mnet.hopto.org
##		p4="$4" # P25 Port 41000
p2=10210
p3=mnet.hopto.org
p4=41000

              	sudo sed -i '/^\[/h;G;/System Fusion/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/mmdvmhost
     		sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/mmdvmhost

          	sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/ysfgateway
         	sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\1'"$1"'/m;P;d' /etc/ysfgateway
          	sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2P25/m;P;d' /etc/ysfgateway
         	sudo sed -i '/^\[/h;G;/Network/s/\(Static=\).*/\1'"$p2"'/m;P;d' /etc/p25gateway
       		sudo sed -i '/^\[/h;G;/General/s/\(^Id=\).*/\1'"$mt"'/m;P;d' /etc/ysfgateway

          	sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\1'"$1"'/m;P;d' /etc/ysf2p25
             	sudo sed -i '/^\[/h;G;/P25 Network/s/\(Enabled=\).*/\1'"$1"'/m;P;d' /etc/ysf2p25
           	sudo sed -i '/^\[/h;G;/P25 Network/s/\(EnableWiresX=\).*/\10/m;P;d' /etc/ysf2p25
         	sudo sed -i '/^\[/h;G;/P25 Network/s/\(StartupDstId=\).*/\1'"$p2"'/m;P;d' /etc/ysf2p25
        	sudo sed -i '/^\[/h;G;/P25 Network/s/\(^Id=\).*/\1'"$m1"'/m;P;d' /etc/ysf2p25

		sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null

       		sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
           	sudo /usr/local/sbin/ysf2p25.service restart  > /dev/null
           	sudo /usr/local/sbin/p25gateway.service restart  > /dev/null

        fi



fi;

sudo mount -o remount,ro /


