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
declare -i pnum

if [ -z "$1" ]; then
        exit
        else
pnum=$(echo $1 | sed 's/^0*//')
#pnum="$1"
		m0=$(sed -nr "/^\[Profile$pnum\]/ { :l /^ssid[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m1=$(sed -nr "/^\[Profile$pnum\]/ { :l /^password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m2=$(sed -nr "/^\[Profile$pnum\]/ { :l /^priority[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)

               	mt="$1|$m0|$m1|$m2"
		echo "$mt"
fi;

