#!/bin/bash
############################################################
#  Set YSF2DMR Parameters                                  #
#							   #
#  Enable "$1" = 1 Sets YSF2DMR Mode			   #
#  Enable "$1" = 0 Clears YSF2DMR Mode & Sets DMR Master   #
#							   #
#  VE3RD                                      2020-01-11   #
############################################################
set -o errexit
set -o pipefail

args=("$@")
sudo mount -o remount,rw /

# Parameter List
#1) 1-On 0-Off to TGIF
#2) WiresXCommandPassthrough / EnableWiresX (1)
#3) Port (62031)
#4) Address  (tgif.network) 
#5) Startup TG (31665)
#6) DMR ID  (xxxxxxx)
#7) Enable Unlink (0)
#8) DMRGateway ON

function default
{
p1=${args[0]}
p2=1
p3=62031
p4=tgif.network
p5=31665
p6=0
p7=0
p8=0
}


function setinputs
{
p7="0"
m1=$(sed -nr "/^\[General\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
p1=${args[0]}    # Cross mode On/Off
p2=${args[1]}	#Wires=x On/Off
p3=62031	#Port
p4=${args[2]}	#Address
p5=${args[3]}	#TG
p6="$m1""03"
p7=${args[4]}	#Disconnect
p8=${args[5]}	#DMRGateway

RR="$p1 $p2 $p3 $p4 $p5 $p6 $p7 $p8"
echo "$RR" > /home/pi-star/ysf2dmr.log
}

if [ -z "$1" ]; then
	echo "You must mprovide at least one paramter"
	echo " Param 1 = 1 to Set YSF2DMR"
	echo " Param 1 = 0 to set TGIF"
exit

fi


if [ -z "$4" ]; then
	echo "Setting Defaults"
	default
else
	echo "Using provided inputs"
	setinputs
fi

sudo mount -o remount,rw /
#sudo /usr/local/sbin/mmdvmhost.service stop 

sudo /usr/local/etc/Nextion_Support/clearallmodes.sh

echo "All Modes Cleared"  >> /home/pi-star/ysf2dmr.log
# If Enabled
	if [ "$p1" == 1 ]; then
sudo mount -o remount,rw /

			echo "Setting MMDVMHost Parameters" >> /home/pi-star/ysf2dmr.log
        		sudo sed -i '/^\[/h;G;/System Fusion]/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
 
			echo "Setting YSF Enable Parameters" >> /home/pi-star/ysf2dmr.log

        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
        		sudo sed -i '/^\[/h;G;/FCS Network/s/\(Enable=\).*/\11/m;P;d' /etc/ysfgateway
        		sudo sed -i '/^\[/h;G;/General/s/\(WiresXCommandPassthrough=\).*/\1'"$p2"'/m;P;d' /etc/ysfgateway
        		sudo sed -i '/^\[/h;G;/Network/s/\(Startup=\).*/\1YSF2DMR/m;P;d' /etc/ysfgateway

        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(EnableUnlink=\).*/\1'"$p7"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/Enabled/s/\(Enabled=\).*/\1'"$p1"'/m;P;d' /etc/ysf2dmr

			echo "Setting YSF General Parameters" >> /home/pi-star/ysf2dmr.log

	       		sudo sed -i '/^\[/h;G;/YSF Network/s/\(EnableWiresX=\).*/\1'"$p2"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$p3"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\162037/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$p4"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(StartupDstId=\).*/\1'"$p5"'/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(^Id=\).*/\1'"$p6"'/m;P;d' /etc/ysf2dmr
#        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(DstPort=\).*/\13200/m;P;d' /etc/ysf2dmr
#        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(LocalPort=\).*/\14200/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(DstPort=\).*/\142000/m;P;d' /etc/ysf2dmr
        		sudo sed -i '/^\[/h;G;/YSF Network/s/\(LocalPort=\).*/\142013/m;P;d' /etc/ysf2dmr

	fi
# If Disabled
	if [ "$p1" == 0 ]; then

			sudo mount -o remount,rw /

			## Ser DMR Master  >> /home/pi-star/ysf2dmr.log

			echo "Setting TGIF Parameters"  >> /home/pi-star/ysf2dmr.log

        		sudo sed -i '/^\[/h;G;/DMR/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Enable=\).*/\11/m;P;d' /etc/mmdvmhost

        		sudo sed -i '/^\[/h;G;/DMR/s/\(^Id=\).*/\1'"$p601"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"$p3"'/m;P;d' /etc/mmdvmhost
        		sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\1'"$p3"'/m;P;d' /etc/mmdvmhost
		
			if [ "$p8" == 0 ]; then
        			sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"$p4"'/m;P;d' /etc/mmdvmhost
				 echo "Starting TGIF Server" >> /home/pi-star/ysf2dmr.log
				sudo sed -i '/^\[/h;G;/DMR Network/s/\(Type=\).*/\1'"Direct"'/m;P;d' /etc/mmdvmhost
			else
				sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"127.0.0.1"'/m;P;d' /etc/mmdvmhost
				sudo sed -i '/^\[/h;G;/DMR Network/s/\(Type=\).*/\1'"Gateway"'/m;P;d' /etc/mmdvmhost
				sudo sed -i '/^\[/h;G;/DMR Network/s/\(Port=\).*/\1'"62032"'/m;P;d' /etc/mmdvmhost
				sudo sed -i '/^\[/h;G;/DMR Network/s/\(Local=\).*/\1'"62032"'/m;P;d' /etc/mmdvmhost
				sudo dmrgateway.service restart
				echo "Starting DMRGateway" >> /home/pi-star/ysf2dmr.log
			fi
  			
	fi

sudo /usr/local/sbin/mmdvmhost.service restart
sudo /usr/local/sbin/ysfgateway.service restart > /dev/null
sudo /usr/local/sbin/ysf2dmr.service restart  > /dev/null
 
echo "Done" >> /home/pi-star/ysf2dmr.log
sudo mount -o remount,ro /


