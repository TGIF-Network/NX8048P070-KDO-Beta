#!/bin/bash
##############################################################
# create basic wpa_supplicant  				     #
# in /home/pi-star/ directory                                #
#                                                            #
#                                                            #
# VE3RD                                         2025-03-24   #
##############################################################



if [ -z "$1" ]; then
  echo "syntax:   updatepi.sh <pi-star ssid or address> <password> "
  exit
fi

piAddress=$1
pw=$2

curl -X POST http://"$piAddress"/admin/configure.php  -u "pi-star:$pw" -d "action=save" -d "config=1"

status=$?

if [ $status -eq 0 ]; then
  echo "Update Script Status = OK"
else
   echo "Update Script Status = Failed"
fi
