#!/bin/bash
############################################################
#  Get Profile Data From Pi-star                           #
#  Returns a multi string | Separated                      #
#                                                          #
#                                                          #
#  VE3RD                                     2019-11-17    #
############################################################
set -o errexit
set -o pipefail
#dirn=/usr/local/etc/Nextion_Support/profiles.txt
dirn=/etc/mmdvmhost

##                m7=$(sed -nr "/^\[Profile $pnum\]/ { :l /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dir>
#                m8=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
#                m9=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Mode[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
#                m10=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Port[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)

#                mt="$m0|$m1|$m2|$m3|$m4|$m5|$m6|$m7|$m8|$m9|$m10"

		ysfnet=$(sed -nr "/^\[System Fusion Network\]/ { :l /^Enable[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		ysf2dmr=$(sed -nr "/^\[System Fusion\]/ { :l /^Enable[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		ysf2nxdn=$(sed -nr "/^\[NXDN\]/ { :l /^Enable[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		ysf2p25=$(sed -nr "/^\[P25\]/ { :l /^Enable[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)

		m1=$(sed -nr "/^\[Modem\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m2=$(sed -nr "/^\[Modem\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m3=$(sed -nr "/^\[Info\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m4=$(sed -nr "/^\[Info\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m5=$(sed -nr "/^\[General\]/ { :l /^Callsign[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m6=$(sed -nr "/^\[General\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m11=$(sed -nr "/^\[Default\]/ { :l /^Password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/profiles.ini)

m7="31665"

		m8=$(sed -nr "/^\[DMR Network\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)

		m9=$(sed -nr "/^\[DMR Network\]/ { :l /^Enable[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
if [ "$m9" == "1" ];then
   	m9="DMR"
	if [ "$m8" == "127.0.0.1" ]; then
		m9="DMRGateway"
	fi
	
fi


#mt=$(sudo sed -n '/^[^#]*'"$m8"'/p' /usr/local/etc/DMR_Hosts.txt | sed -E "s/[[:space:]]+/|/g")
#m8=$( echo "$mt" | cut -d'|' -f1)


if [ ysfnet == 1 ]; then
	m7=$(sed -nr "/^\[System Fusion Network\]/ { :l /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/ysf2dmr)
 	if [ ysf2dmr == 1 ]; then 
		m7="YSF2DMR" 
	fi
 	if [ ysf2nxdn == 1 ]; then 
		m7="YSF2NXDN" 
	fi
 	if [ ysf2p25 == 1 ]; then 
		m7="YSF2P25" 
	fi

fi
case $m9 in
	"DMR")
    	m7="31665"
	m10=$(sed -nr "/^\[DMR Network\]/ { :l /^Port[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)

    ;;

  	"DMRGateway")
    	m7="31665"
	m10=$(sed -nr "/^\[DMR Network\]/ { :l /^Port[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
    ;;
   
        "127.0.0.2")
        m7="DMR2YSF"
	m10="62031"

    ;;
        "127.0.0.3")
        m7-"DMR2NXDN"
	m10="62031"
    ;;
esac

               	mt="0|Pi-Star|$m1|$m2|$m3|$m4|$m5|$m6|$m7|$m8|$m9|$m10|$m11"
		echo "$mt"

