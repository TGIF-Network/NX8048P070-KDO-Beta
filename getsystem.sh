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

		m1=$(sed -nr "/^\[Modem\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m2=$(sed -nr "/^\[Modem\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m3=$(sed -nr "/^\[Info\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m4=$(sed -nr "/^\[Info\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m5=$(sed -nr "/^\[General\]/ { :l /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m6=$(sed -nr "/^\[General\]/ { :l /^Callsign[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)


		m7=$(sed -nr "/^\[General\]/ { :l /^Duplex[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m8=$(sed -nr "/^\[NextionDriver\]/ { :l /^LogLevel[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m9=$(sed -nr "/^\[NextionDriver\]/ { :l /^WaitForLan[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m10=$(sed -nr "/^\[NextionDriver\]/ { :l /^SleepWhenInactive[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)


               	mt="$m1|$m2|$m3|$m4|$m5|$m6|$m7|$m8|$m9|$m10"
		echo "$mt"

