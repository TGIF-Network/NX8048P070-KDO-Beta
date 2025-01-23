#!/bin/bash
############################################################
#  Set DMR2NXDN Parameters                                  #
#							   #
#  Enable "$1" = 1 Sets DMR2NXDN Mode			   #
#							   #
#  VE3RD                                      2024-04-27   #
############################################################
set -o errexit
set -o pipefail
# Check all five cross modes and set each one to either 0 or 1
#Clear all Main Modes

if [ -z "$2" ]; then
    exit
else
sudo mount -o remount,rw /

	m1=$(sed -nr "/^\[General\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
	wlist="$m1""03"
        sudo sed -i '/^\[/h;G;/DMR/s/\(WhiteList=\).*/\1'"$wlist"'/m;P;d' /etc/dmr2nxdn

#	sudo /usr/local/sbin/mmdvmhost.service stop  > /dev/null
	sudo mount -o remount,rw /
	#1 Enable
	#2 Target
	echo "$1|$2|$3|$4|$5" >  /home/pi-star/dmr2nxdn.txt
	sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
	#echo "All Modes Cleared"
	# If Enabled

	if [ "$1" == "1" ] && [ "$2" == "1" ]; then

                sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/dmr2nxdn
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(DefaultDstTG=\).*/\1'"32592"'/m;P;d' /etc/dmr2nxdn
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(LocalAddress=\).*/\1'"127.0.0.1"'/m;P;d' /etc/dmr2nxdn
##
                sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m1"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR/s/\(^WhiteList=\).*/\1'"$m1"'/m;P;d' /etc/mmdvmhost

                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Enabled=\).*/\11/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^TGRewrite0=\).*/\1'"2,13000001,2,1,999998"'/m;P;d' /etc/dmrgateway

                sudo sed -i '/^\[/h;G;/Network/s/\(^Startup=\).*/\1'"US-America-Link"'/m;P;d' /etc/NXDNgateway

                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Name=\).*/\1'"DMR2NXDN Crossover"'/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Address=\).*/\1'"127.0.0.1"'/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Port=\).*/\162033/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Local=\).*/\162034/m;P;d' /etc/dmrgateway

                sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Type=\).*/\1'"Gateway"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"none"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.3/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(RemoteAddress=\).*/\1127.0.0.3/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162032/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(RemotePort=\).*/\162031/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(LocalPort=\).*/\162032/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/NXDN Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost


		sudo /usr/local/sbin/mmdvmhost.service start  > /dev/null
                sudo /usr/local/sbin/dmr2NXDN.service restart > /dev/null
                sudo /usr/local/sbin/NXDNgateway.service restart > /dev/null
                sudo /usr/local/sbin/dmrgateway.service restart > /dev/null
		echo "Setting DMRgateway OFF DMR2NXDN ON"
	fi
	if [ "$1" == "0" ] && [ "$2" == "1" ]; then

                sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/dmr2nxdn
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(DefaultDstTG=\).*/\1'"32592"'/m;P;d' /etc/dmr2nxdn
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(LocalAddress=\).*/\1'"127.0.0.3"'/m;P;d' /etc/dmr2nxdn
##
                sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m1"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR/s/\(^WhiteList=\).*/\1'"$m1"'/m;P;d' /etc/mmdvmhost

                sudo sed -i '/^\[/h;G;/Network/s/\(^Startup=\).*/\1'"US-America-Link"'/m;P;d' /etc/nxdngateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Enabled=\).*/\11/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^TGRewrite0=\).*/\1'"2,13000001,2,1,999998"'/m;P;d' /etc/dmrgateway

                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Name=\).*/\1'"DMR2NXDN Crossover"'/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Address=\).*/\1'"127.0.0.3"'/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Port=\).*/\162035/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Local=\).*/\162036/m;P;d' /etc/dmrgateway

                sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Type=\).*/\1'"Direct"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"none"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.3/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(RemoteAddress=\).*/\1127.0.0.3/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162035/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162036/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(RemotePort=\).*/\162035/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(LocalPort=\).*/\162036/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/NXDN Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost

		sudo /usr/local/sbin/mmdvmhost.service start  > /dev/null
                sudo /usr/local/sbin/dmr2nxdn.service restart > /dev/null
                sudo /usr/local/sbin/nxdngateway.service restart > /dev/null
                sudo /usr/local/sbin/dmrgateway.service restart > /dev/null


		echo "Setting DMRgateway OFF DMR2NXDN ON"
sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null
	fi
	
# If Disabled
	if [ "$1" = 0 ] &&  [ "$2" = 0 ]; then
		#DMRGateway OFF / DMR2NXDN OFF - Set Master Server to TGIF

        		sudo sed -i '/^\[/h;G;/DMR/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Port=\).*/\162031/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m1"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1tgif.network/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"passw0rd"'/m;P;d' /etc/mmdvmhost
		echo "Setting Master DMR to TGIF"
sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null
  
	fi
	if [ "$1" = 1 ] &&  [ "$2" = 0 ]; then
		#DMRGateway ON / DMR2NXDN OFF
        		sudo sed -i '/^\[/h;G;/DMR/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Port=\).*/\162031/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m1"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1'"127.0.0.1"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"passw0rd"'/m;P;d' /etc/mmdvmhost
  		echo "Setting DMRgateway ON DMR2NXDN OFF"
sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null

	fi

fi;
sudo mount -o remount,ro /


