#!/bin/bash
###########################################################
#  Change RXOffset in mmdvmhost			          # 
#                                                         #
#  VE3RD                                      2025-02-15  #
###########################################################
set -o errexit
set -o pipefail
# Get old RXOffset value in $1 and new value to set in $2
#Put Pi-Star file system in RW mode
#Use SED to replace RXOffset in mmdvmhost
#chgrx() { sed -i 's+RXOffset='"$1"'+RXOffset='"$2"'+' /etc/mmdvmhost; }
#chgrx $1 $2;
sudo mount -o remount,rw /

 sudo sed -i '/^\[/h;G;/Modem/s/\(RXOffset=\).*/\1'"$1"'/m;P;d' /etc/mmdvmhost

sudo mount -o remount,ro /
sudo mmdvmhost.service restart
