#!/bin/bash
############################################################
#  Get Color Info from /usr/local/etc/ColorThemes.ini      #
#                                                          #
#                                                          #
#  VE3RD                                      2024-04-17   #
############################################################
set -o errexit
set -o pipefail

m1=$(sed -nr "/^\[MMDVM]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
m2=$(sed -nr "/^\[DMR]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
m3=$(sed -nr "/^\[YSF]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
m4=$(sed -nr "/^\[NXDN]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
m5=$(sed -nr "/^\[P25]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
m6=$(sed -nr "/^\[D-Star]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
m7=$(sed -nr "/^\[M17]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
mt="$m1|$m2|$m3|$m4|$m5|$m6|$m7"
 

echo "$mt"


