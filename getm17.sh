#!/bin/bash
############################################################
#  Get M17 Reflector 			                   #
#                                                          #
#  VE3RD                                        2024-12=11 #
############################################################
set -o errexit
set -o pipefail
m1=$(sed -nr "/^\[Network\]/ { :1 /^Startup[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/m17gateway)
echo "$m1"
