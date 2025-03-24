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

		p0=$(sed -nr "/^\[Profile0\]/ { :l /^priority[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		p1=$(sed -nr "/^\[Profile1\]/ { :l /^priority[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		p2=$(sed -nr "/^\[Profile2\]/ { :l /^priority[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		p3=$(sed -nr "/^\[Profile3\]/ { :l /^priority[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		p4=$(sed -nr "/^\[Profile4\]/ { :l /^priority[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)

		n0=$(sed -nr "/^\[Profile0\]/ { :l /^id_str[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn | tr -d '"')
		n1=$(sed -nr "/^\[Profile1\]/ { :l /^id_str[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn | tr -d '"')
		n2=$(sed -nr "/^\[Profile2\]/ { :l /^id_str[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn | tr -d '"')
		n3=$(sed -nr "/^\[Profile3\]/ { :l /^id_str[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn | tr -d '"')
		n4=$(sed -nr "/^\[Profile4\]/ { :l /^id_str[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn | tr -d '"')

               	mt="$m0|$m1|$m2|$m3|$m4|$p0|$p1|$p2|$p3|$p4|$n0|$n1|$n2|$n3|$n4"
		echo "$mt"

