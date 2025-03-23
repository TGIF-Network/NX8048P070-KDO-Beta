#!/bin/bash
#################################################
#  Get RXOffset from MMDVMHost and 		#
#   Get BER from MMDVM Log			#
#						#
#						#
#  VE3RD 			2025-02-15	#
#################################################
set -o errexit
set -o pipefail

#M: 2025-02-03 17:22:01.279 DMR Slot 2, received RF end of voice transmission from VE3RD to TG 14031665, 0.4 seconds, BER: 0.0%, RSSI: -47/-47/-47 dBm
#                                           7    8  9   10   11     12         13    14  15 16   17      18    19     20    21    22       23  

#M: 2025-03-16 00:24:00.184 YSF, received network end of transmission from VE3RD      to DG-ID 0, 2.7 seconds, 0% packet loss, BER: 0.0%

f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
#list1=$(sudo sed -n '/received RF end of voice transmission/p' $f1 | tail -1)
list1=$(sudo sed -n '/transmission from/p' $f1 | tail -1)
mode=$(echo "$list1" | cut -d " " -f4 | tr -d ',')
ber=$(echo "$list1" | cut -d " " -f21 | tr -d ',' )
if [ "$ber" == "packet" ]; then
   ber="N/A"
fi
RXO=$(sed -nr "/^\[Modem\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /etc/mmdvmhost)
#echo "$list1"
mm="$RXO|$mode|$ber"
echo "$mm"

