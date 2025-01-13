#!/bin/bash
############################################################
#  Get  Mode Color from /Etc/ColorThemes.ini from          #
#                                                          #
#                                                          #
#  VE3RD                                      2025-01-11   #
############################################################
set -o errexit
set -o pipefail


# Color Numbers
# Teal=1
# Black=2
# Green=3
# Yellow=4
# Blue=5
# Red=6

if [ "$1" == "MMDVM" ]; then
  th=$(sed -nr "/^\[MMDVM]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  Split=$(sed -nr "/^\[MMDVM]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  
fi

if [ "$1" == "DMR" ]; then
  th=$(sed -nr "/^\[DMR]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  Split=$(sed -nr "/^\[DMR]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
fi
if [ "$1" == "YSF" ]; then
  th=$(sed -nr "/^\[YSF]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  Split=$(sed -nr "/^\[YSF]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
fi

if [ "$1" == "NXDN" ]; then
  th=$(sed -nr "/^\[NXDN]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  Split=$(sed -nr "/^\[NXDN]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
fi
if [ "$1" == "P25" ]; then
  th=$(sed -nr "/^\[P25]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  Split=$(sed -nr "/^\[P25]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
fi

if [ "$1" == "D-Star" ]; then
  th=$(sed -nr "/^\[D-Star]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  Split=$(sed -nr "/^\[D-Star]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
fi
if [ "$1" == "M17" ]; then
  th=$(sed -nr "/^\[M17]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  Split=$(sed -nr "/^\[M17]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
fi
echo "Theme$th"
thm="Theme$th"
	Cn=$(sed -nr "/^\["$thm"]/ { :1 /^Color[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
	CB1=$(sed -nr "/^\["$thm"]/ { :1 /^CB1[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
	CT1=$(sed -nr "/^\["$thm"]/ { :1 /^CT1[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
	CB2=$(sed -nr "/^\["$thm"]/ { :1 /^CB2[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
	CT2=$(sed -nr "/^\["$thm"]/ { :1 /^CT2[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)

mt="$th|$Split|$Cn|$CB1|$CT1|$CB2|$CT2"
echo "$mt"
