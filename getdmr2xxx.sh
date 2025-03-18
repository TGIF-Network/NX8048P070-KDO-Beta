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


m1=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmr2ysf)
m2=$(sed -nr "/^\[DMR Network\]/ { :1 /^DefaultDstTG[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmr2ysf)
m3=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmr2nxdn)
m4=$(sed -nr "/^\[Network\]/ { :1 /^Static[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/nxdngateway)

mt="$m1|$m2|$m3|$m4"
echo "$mt"


