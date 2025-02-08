#!/bin/bash
############################################################
#  Get Profile Data From Pi-star                           #
#  Returns a multi string | Separated                      #
#                                                          #
#                                                          #
#  VE3RD                                     2019-11-17    #
############################################################
set -o errexit
set -o pipefail

 FILE=/usr/local/etc/NX4832K035.tft
 if [ ! -f "$FILE" ]; then
        # Copy failed
      echo "No TFT File Available to Flash - Try Again"
  else
   echo "NX4832K035.tft File Found! Proceed!"

 fi

