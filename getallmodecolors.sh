#!/bin/bash
############################################################
#  Get  Mode Color from /Etc/ColorThemes.ini from          #
#                                                          #
#                                                          #
#  VE3RD                                      2025-01-11   #
############################################################
set -o errexit
set -o pipefail

  m0=$(sed -nr "/^\[MMDVM]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  s0=$(sed -nr "/^\[MMDVM]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
 m1=$(sed -nr "/^\[DMR]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  s1=$(sed -nr "/^\[DMR]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
 m2=$(sed -nr "/^\[YSF]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  s2=$(sed -nr "/^\[YSF]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  m3=$(sed -nr "/^\[NXDN]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  s3=$(sed -nr "/^\[NXDN]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  m4=$(sed -nr "/^\[P25]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
   s4=$(sed -nr "/^\[P25]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
 m5=$(sed -nr "/^\[D-Star]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  s5=$(sed -nr "/^\[D-Star]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  m6=$(sed -nr "/^\[M17]/ { :1 /^Theme[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)
  s6=$(sed -nr "/^\[M17]/ { :1 /^Split[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ColorThemes.ini)

mt="$m0|$s0|$m1|$s1|$m2|$s2|$m3|$s3|$m4|$s4|$m5|$s5|$m6|$s6"
echo "$mt"
