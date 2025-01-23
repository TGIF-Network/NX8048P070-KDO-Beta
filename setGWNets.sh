#!/bin/bash
############################################################
#  Set or DMR Gateway Configuration                        #
#  VE3RD                                      2019/11/14   #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /
#echo "Set DMRGateway"

if [ -z "$2" ]; then
        exit
fi
 if [ "$1" == "0" ]; then
       sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"tgif.network"'/m;P;d'  /etc/mmdvmhost
 else
       sudo sed -i '/^\[/h;G;/DMR Network/s/\(Address=\).*/\1'"127.0.0.1"'/m;P;d'  /etc/mmdvmhost


       sudo sed -i '/^\[/h;G;/Network 1/s/\(Enabled=\).*/\1'"$2"'/m;P;d'  /etc/dmrgateway
        sudo sed -i '/^\[/h;G;/Network 2/s/\(Enabled=\).*/\1'"$3"'/m;P;d'  /etc/dmrgateway
        sudo sed -i '/^\[/h;G;/Network 3/s/\(Enabled=\).*/\1'"$4"'/m;P;d'  /etc/dmrgateway
        sudo sed -i '/^\[/h;G;/Network 4/s/\(Enabled=\).*/\1'"$5"'/m;P;d'  /etc/dmrgateway
        sudo sed -i '/^\[/h;G;/Network 5/s/\(Enabled=\).*/\1'"$6"'/m;P;d'  /etc/dmrgateway
        sudo sed -i '/^\[/h;G;/Network 6/s/\(Enabled=\).*/\1'"$7"'/m;P;d'  /etc/dmrgateway

fi
sudo mmdvmhost.service restart
sudo dmrgateway.service restart

