#!/bin/bash
############################################################
#  Get  System Info from                                   #
#                                                          #
#  VE3RD                                       2025-02-07  #
############################################################
set -o errexit
set -o pipefail

m1=$(sudo MMDVMHost -v | cut -d ' ' -f3,5)
m2=$(sudo DMRGateway -v | cut -d ' ' -f3,5)
m3=$(sudo NextionDriver -V | tr '\n' ' A' | cut -d ' ' -f4 | tr '\n' ' ')
echo "$m1|$m2|$m3"

