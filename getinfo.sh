#!/bin/bash
############################################################
#  Get  System Info from                                   #
#                                                          #
#  VE3RD                                       2025-02-07  #
############################################################
set -o errexit
set -o pipefail

m1=$(sudo cat /etc/os-release | head -1 | cut -d '=' -f2 | tr -d '"')
m2=$(sudo cat /etc/pistar-release | head -2 | tail -1 | cut -d '=' -f2 | tr -d '"')
m3=$(sudo cat /proc/cpuinfo | head -2 | tail -1 | cut -d ':' -f2 | tr -d '"')
m4=$(cat /proc/meminfo |head -3 |head -1 | tr -d ' ')
m5=$(cat /proc/meminfo |head -3 |tail -1 | tr -d ' ')
m6=$(cat /etc/pistar-release | head -3 | tail -1 | tr -d ' ')
echo "$m1|$m2|$m3|$m4|$m5|$m6"


 cat /etc/pistar-release | head -3 | tail -1 | tr -d ' ' 
