#!/bin/bash
############################################################
#  Set DMR2YSF Parameters                                  #
#							   #
#  Enable "$1" = 1 Sets DMR2YSF Mode			   #
#							   #
#  VE3RD                                      2024-04-27   #
############################################################
set -o errexit
set -o pipefail
# Check all five cross modes and set each one to either 0 or 1
#Clear all Main Modes
#P1=Address/Server
#P2=DMR2YSF ON/OFF

if [ -z "$2" ]; then
    exit
else

	m1=$(sed -nr "/^\[General\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
	wlist="$m1""02"

#	sudo /usr/local/sbin/mmdvmhost.service stop  > /dev/null
	sudo mount -o remount,rw /
	#1 Enable
	#2 Target
	echo "$1|$2|$3|$4|$5" >  /home/pi-star/dmr2ysf.txt
	sudo /usr/local/etc/Nextion_Support/clearallmodes.sh
	#echo "All Modes Cleared"
	# If Enabled
        sudo sed -i '/^\[/h;G;/DMR/s/\(^WhiteList=\).*/\1'"$wlist"'/m;P;d' /etc/mmdvmhost

	if [ "$1" == "1" ] && [ "$2" == "1" ]; then
		# DMRGateway ON,   DMR2YSF ON
                sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/dmr2ysf
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(DefaultDstTG=\).*/\1'"32592"'/m;P;d' /etc/dmr2ysf
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(LocalAddress=\).*/\1'"127.0.0.1"'/m;P;d' /etc/dmr2ysf
##
                sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m101"'/m;P;d' /etc/mmdvmhost


                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Enabled=\).*/\11/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^TGRewrite0=\).*/\1'"2,13000001,2,1,999998"'/m;P;d' /etc/dmrgateway

                sudo sed -i '/^\[/h;G;/Network/s/\(^Startup=\).*/\1'"US-America-Link"'/m;P;d' /etc/ysfgateway
                sudo sed -i '/^\[/h;G;/YSF Network/s/\(^Enable=\).*/\11/m;P;d' /etc/ysfgateway
                sudo sed -i '/^\[/h;G;/FCS Network/s/\(^Enable=\).*/\11/m;P;d' /etc/ysfgateway

                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Name=\).*/\1'"DMR2YSF Crossover"'/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Address=\).*/\1'"127.0.0.1"'/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Port=\).*/\162033/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Local=\).*/\162034/m;P;d' /etc/dmrgateway

                sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Type=\).*/\1'"Gateway"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"none"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.1/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(RemoteAddress=\).*/\1127.0.0.1/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162031/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162032/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(RemotePort=\).*/\162031/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(LocalPort=\).*/\162032/m;P;d' /etc/mmdvmhost

                sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost

		sudo /usr/local/sbin/mmdvmhost.service start  > /dev/null
                sudo /usr/local/sbin/dmr2ysf.service restart > /dev/null
                sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                sudo /usr/local/sbin/dmrgateway.service restart > /dev/null
		echo "Setting DMRgateway OFF DMR2YSF ON"
	fi
	if [ "$1" == "0" ] && [ "$2" == "1" ]; then
		# DMRGateway OFF,   DMR2YSF ON

                sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\11/m;P;d' /etc/dmr2ysf
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(DefaultDstTG=\).*/\1'"32592"'/m;P;d' /etc/dmr2ysf
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(LocalAddress=\).*/\1'"127.0.0.2"'/m;P;d' /etc/dmr2ysf
##
                sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m101"'/m;P;d' /etc/mmdvmhost

                sudo sed -i '/^\[/h;G;/Network/s/\(^Startup=\).*/\1'"US-America-Link"'/m;P;d' /etc/ysfgateway
                sudo sed -i '/^\[/h;G;/YSF Network/s/\(^Enable=\).*/\11/m;P;d' /etc/ysfgateway
                sudo sed -i '/^\[/h;G;/FCS Network/s/\(^Enable=\).*/\11/m;P;d' /etc/ysfgateway
  

                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Enabled=\).*/\11/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^TGRewrite0=\).*/\1'"2,13000001,2,1,999998"'/m;P;d' /etc/dmrgateway

                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Name=\).*/\1'"DMR2YSF Crossover"'/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Address=\).*/\1'"127.0.0.2"'/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Port=\).*/\162033/m;P;d' /etc/dmrgateway
                sudo sed -i '/^\[/h;G;/DMR Network 3/s/\(^Local=\).*/\162034/m;P;d' /etc/dmrgateway

                sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Type=\).*/\1'"Direct"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"none"'/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1127.0.0.2/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(RemoteAddress=\).*/\1127.0.0.2/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\162033/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162034/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(RemotePort=\).*/\162033/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/DMR Network/s/\(LocalPort=\).*/\162034/m;P;d' /etc/mmdvmhost

                sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
                sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost

		sudo /usr/local/sbin/mmdvmhost.service start  > /dev/null
                sudo /usr/local/sbin/dmr2ysf.service restart > /dev/null
                sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
                sudo /usr/local/sbin/dmrgateway.service restart > /dev/null

		echo "Setting DMRgateway OFF DMR2YSF ON"
sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null
	fi
	
# If Disabled
	if [ "$1" = 0 ] &&  [ "$2" = 0 ]; then
		#DMRGateway OFF / DMR2YSF OFF - Set Master Server to TGIF

        		sudo sed -i '/^\[/h;G;/DMR/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Port=\).*/\162031/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m101"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1tgif.network/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"passw0rd"'/m;P;d' /etc/mmdvmhost
		echo "Setting Master DMR to TGIF"
		sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null
  
	fi
	if [ "$1" = 1 ] &&  [ "$2" = 0 ]; then
		#DMRGateway ON / DMR2YSF OFF
        		sudo sed -i '/^\[/h;G;/DMR/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Port=\).*/\162031/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$m101"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Address=\).*/\1'"127.0.0.1"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Password=\).*/\1'"passw0rd"'/m;P;d' /etc/mmdvmhost
  		echo "Setting DMRgateway ON DMR2YSF OFF"
		sudo /usr/local/sbin/mmdvmhost.service restart  > /dev/null

	fi

fi;
sudo mount -o remount,ro /


