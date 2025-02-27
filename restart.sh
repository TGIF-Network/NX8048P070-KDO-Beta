#!/bin/bash
############################################################
#  Restart Nextion Driver and MMDVMHost                    #
#  VE3RD                                      2025-02-27   #
############################################################
set -o errexit
set -o pipefail
nextiondriver.service restart
sleep 5
mmdvmhost.service restart
