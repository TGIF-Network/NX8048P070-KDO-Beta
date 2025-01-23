#!/bin/bash
############################################################
#  Change Crosmode Mode in /etc/XXX2YYY                    #
#  VE3RD                                      2025-01-21   #
############################################################
set -o errexit
set -o pipefail

if [ -z "$5" ]; then
        exit
  else
sudo mount -o remount,rw /
#ysf2dmr
#ysf2nxdn
#ysf2p25
#dmr2ysf
#dmr2nxdn
	sudo /usr/local/etc/Nextion_Support/clearallmodes.sh

	on="0"

        if [ "$1" = "1" ]; then 
		on="1"
		 sudo /usr/local/etc/Nextion_Support/setysf2dmr.sh 1
        fi

        if [ "$2" = "1" ]; then 
		on="1"
		 sudo /usr/local/etc/Nextion_Support/setysf2nxdn.sh 1
	 fi

        if [ "$3" = "1" ]; then 
		on="1"
		 sudo /usr/local/etc/Nextion_Support/setysf2p25.sh 1
	 fi


        if [ "$4" = "1" ]; then 
		on="1"
		 sudo /usr/local/etc/Nextion_Support/setdmr2ysf.sh "$6" 1

       fi


        if [ "$5" = "1" ]; then 
		on="1"
		 sudo /usr/local/etc/Nextion_Support/setdmr2nxdn.sh "$6" 1
        fi

  #      if [ "$on" = "0" ]; then 
#		on="1"
#		 sudo /usr/local/etc/Nextion_Support/setdmr2nxdn.sh 0 1
 #       fi



 sudo mmdvmhost.service restart
sudo mount -o remount,ro /

fi;
