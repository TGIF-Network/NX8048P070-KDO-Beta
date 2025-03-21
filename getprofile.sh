#!/bin/bash
############################################################
#  Get  Profile from profiles.txt                          #
#  Returns a multi string | Separated                      #
#                                                          #
#                                                          #
#  VE3RD                                     2020-05-12    #
############################################################
set -o errexit
set -o pipefail
ver="20200512"
dirn=/etc/profiles.ini
declare -i pnum

if [ -z "$1" ]; then
        exit
        else
pnum=$(echo $1 | sed 's/^0*//')
#pnum="$1"
		m0=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Name[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m1=$(sed -nr "/^\[Profile $pnum\]/ { :l /^RXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m2=$(sed -nr "/^\[Profile $pnum\]/ { :l /^TXOffset[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m3=$(sed -nr "/^\[Profile $pnum\]/ { :l /^RXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m4=$(sed -nr "/^\[Profile $pnum\]/ { :l /^TXFrequency[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m5=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
		m6=$(sed -nr "/^\[Profile $pnum\]/ { :l /^WhiteList[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn | tr -d '"')
		m7=$(sed -nr "/^\[Profile $pnum\]/ { :l /^Password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn | tr -d '"')
               	mt="$1|$m0|$m1|$m2|$m3|$m4|$m5|$m6|$m7"
		echo "$mt"
fi;
#echo "$m11"
