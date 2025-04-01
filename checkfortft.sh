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
#Sun  9 Feb 10:13:59 EST 2025

 FILE=/usr/local/etc/NX8048P070.tft
#F1=$(date -r  /usr/local/etc/NX4832K035.tft | sed 's/ /-/g')
F1=$(date -r  /usr/local/etc/NX8048P070.tft | tr '  ' ' ')

dt4=$(date -r /usr/local/etc/NX8048P070.tft | cut -d " " -f5)

#dt="$dt3 $dt2  $dt1"

dtt=$(stat /usr/local/etc/NX8048P070.tft | grep Birth | cut -d '.' -f1 | cut -d ' ' -f3,4)
#echo "$dtt"

tag=$(git -C /home/pi-star/Nextion_Temp/ tag)
 if [ ! -f "$FILE" ]; then
        # Copy failed
      echo "No TFT File Available to Flash - Try Again"
  else
   echo "NX7048P070.tft File Found!\r Repo Tag: $tag"

 fi

