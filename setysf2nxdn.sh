#!/bin/bash
############################################################
#  Set YSF2NXDN Parameters                                 #
#							   #
#  Enable "$1" = 1 Sets YSF2NXDN Mode			   #
#  Enable "$1" = 0 Clears YSF2NXDN Mode & Sets DMR Master  #
#							   #
#  VE3RD                                      2020-01-11   #
############################################################
set -o errexit
set -o pipefail
# Check all five cross modes and set each one to either 0 or 1
#Clear all Main Modes

if [ -z "$1" ]; then
    exit
else
m1=$(sed -nr "/^\[General\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
m2=$(sed -nr "/^\[General\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
	p1="$1" ## YSF2NXDN Enable
	p2="$2" ## TG
	p3="$3" ## NXDN Id

	tab=$'\t'               # `tab=$(printf '\t')` in POSIX
	##grep "$name$tab$id"     # matches eg. `bob2<tab>323`


	addr=$(grep "$p2$tab" /usr/local/etc/NXDNHosts.txt |cut -d $'\t' -f2)
	port=$(grep "$p2$tab" /usr/local/etc/NXDNHosts.txt |cut -d $'\t' -f3)

	echo "$addr $port"

	sudo mount -o remount,rw /
#	sudo /usr/local/sbin/mmdvmhost.service stop  > /dev/null
	sudo /usr/local/etc/Nextion_Support/clearallmodes.sh


        if [ "$1" = 1 ]; then
                        sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
			 sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2NXDN/m;P;d' /etc/ysfgateway
                        sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway

                        sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2nxdn
#                        sudo sed -i '/^\[/h;G;/NXDN Network/s/\(Enabled=\).*/\11/m;P;d' /etc/ysf2nxdn
                        sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\11/m;P;d' /etc/ysf2nxdn
                        sudo sed -i '/^\[/h;G;/NXDN Network/s/\(StartupDstId=\).*/\1'"$p2"'/m;P;d' /etc/ysf2nxdn
                        sudo sed -i '/^\[/h;G;/NXDN Network/s/\(^Id=\).*/\1'"$p3"'/m;P;d' /etc/ysf2nxdn

                        sudo sed -i '/^\[/h;G;/Network/s/\(^Static=\).*/\1'"$p2"'/m;P;d' /etc/nxdngateway




                        sudo sed -i '/^\[/h;G;/System Fusion/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                        sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost

# If Enabled
#                        sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\10/m;P;d' /etc/mmdvmhost
#                        sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\10/m;P;d' /etc/mmdvmhost

                        sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                        sudo /usr/local/sbin/ysf2nxdn.service restart  > /dev/null
                        sudo /usr/local/sbin/nxdngateway.service restart  > /dev/null
        fi

fi;
sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null
sudo mount -o remount,ro /





