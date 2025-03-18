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


m1=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
m2=$(sed -nr "/^\[DMR Network\]/ { :1 /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
m3=$(sed -nr "/^\[DMR Network\]/ { :1 /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)

mt="$m1|$m2|$m3"
echo "$mt"
