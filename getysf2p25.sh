#!/bin/bash
############################################################
#  Get Cross Mode                                          #
#                                                          #
#  Returns a string of | separated variables               #
#                                                          #
#  VE3RD                                        2025-01-21 #
############################################################
set -o errexit
set -o pipefail

#Order
#YSF2DMR
#YSF2NXDN
#YSF2P25

#DMR2YSF
#DMR2NXDN
#

m1=tgif.network
m2=62031
m3=31665


m4=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2p25)
 
m5=$(sed -nr "/^\[Network\]/ { :1 /^Static[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/p25gateway)

if [ -z "$m5" ]; then
m5=10210
fi
mt="$m1|$m2|$m3|$m4|$m5"
echo "$mt"
