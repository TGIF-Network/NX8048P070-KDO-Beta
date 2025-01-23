#!/bin/bash
############################################################
#  Set DMR Master Parameters                               #
#                                                          #
#                                                          #
#  VE3RD                                      2024-04-29   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

m1=$(sed -nr "/^\[General\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
m2=$(sed -nr "/^\[DMR\]/ { :1 /^WhiteList[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)

#sudo /usr/local/sbin/mmdvmhost.service stop  > /dev/null
sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
p1="$1" ##dmr server address or 127.0.0.1 forDMRGateway
p2="$2" ## Port
p3="$3" ## TG

emd="$m1""01"

sudo mount -o remount,rw /

  	## Ser DMR Master  >> /home/pi-star/ysf2dmr.log

	sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
  	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost

   	sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$emd"'/m;P;d' /etc/mmdvmhost
  	sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"62031"'/m;P;d' /etc/mmdvmhost

  	if [ "$p1" == "127.0.0.1" ]; then
  		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"127.0.0.1"'/m;P;d' /etc/mmdvmhost
 		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Type=\).*/\1'"Gateway"'/m;P;d' /etc/mmdvmhost
 		sudo sed -i '/^\[/h;G;/DMR Network/s/\(RemotePort=\).*/\1'"62031"'/m;P;d' /etc/mmdvmhost
 		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"62031"'/m;P;d' /etc/mmdvmhost
 		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\1'"62032"'/m;P;d' /etc/mmdvmhost
 		sudo sed -i '/^\[/h;G;/DMR Network/s/\(LocalPort=\).*/\1'"62032"'/m;P;d' /etc/mmdvmhost
   		sudo dmrgateway.service restart
	else

   		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$p1"'/m;P;d' /etc/mmdvmhost
       		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Type=\).*/\1'"Direct"'/m;P;d' /etc/mmdvmhost
   		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"62031"'/m;P;d' /etc/mmdvmhost
   		sudo sed -i '/^\[/h;G;/DMR Network/s/\(LocalPort=\).*/\1'"62031"'/m;P;d' /etc/mmdvmhost
 		sudo sed -i '/^\[/h;G;/DMR Network/s/\(RemotePort=\).*/\1'"62031"'/m;P;d' /etc/mmdvmhost

	fi


sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null

sudo mount -o remount,ro /
