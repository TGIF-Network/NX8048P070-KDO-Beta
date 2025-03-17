#!/bin/bash
############################################################
#  Get NXDN ID		                                   #
#							   #
#							   #
#  VE3RD                                      2020-01-11   #
############################################################
set -o errexit
set -o pipefail

m1=$(sed -nr "/^\[General\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/mmdvmhost)
m2=$(sed -nr "/^\[NXDN Network\]/ { :1 /^Id[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2nxdn)

echo "$m2"




