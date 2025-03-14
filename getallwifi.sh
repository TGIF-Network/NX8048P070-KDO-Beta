#!/bin/bash
############################################################
# Get  WiFi Profile from /etc/wifiprofiles.ini             #
#  Returns a multi string | Separated                      #
#                                                          #
#                                                          #
#  VE3RD                                     2025-03-14    #
############################################################
set -o errexit
set -o pipefail
dirn=/etc/wifiprofiles.ini
		m0=$(sed -nr "/^\[Profile0\]/ { :l /^ssid[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m1=$(sed -nr "/^\[Profile1\]/ { :l /^ssid[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m2=$(sed -nr "/^\[Profile2\]/ { :l /^ssid[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m3=$(sed -nr "/^\[Profile3\]/ { :l /^ssid[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m4=$(sed -nr "/^\[Profile4\]/ { :l /^ssid[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)

               	mt="$m0|$m1|$m2|$m3|$m4"
		echo "$mt"

