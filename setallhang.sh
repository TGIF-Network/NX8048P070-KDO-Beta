#!/bin/bash
####################################################################
#  Change ModeHang in /etc/mmdvmhost                               #
#                                                                  #
#  VE3RD                                              2025-01-19   #
####################################################################
set -o errexit
set -o pipefail

 sudo mount -o remount,rw /

        sudo sed -i '/^\[/h;G;/D-Star/s/\(ModeHang=\).*/\1'"$1"'/m;P;d'  /etc/mmdvmhost
        sudo sed -i '/^\[/h;G;/D-Star Network/s/\(ModeHang=\).*/\1'"$2"'/m;P;d'  /etc/mmdvmhost

        sudo sed -i '/^\[/h;G;/DMR/s/\(ModeHang=\).*/\1'"$3"'/m;P;d'  /etc/mmdvmhost
        sudo sed -i '/^\[/h;G;/DMR Network/s/\(ModeHang=\).*/\1'"$4"'/m;P;d'  /etc/mmdvmhost

        sudo sed -i '/^\[/h;G;/System Fusion/s/\(ModeHang=\).*/\1'"$5"'/m;P;d'  /etc/mmdvmhost
        sudo sed -i '/^\[/h;G;/System Fusion Network/s/\(ModeHang=\).*/\1'"$6"'/m;P;d'  /etc/mmdvmhost

        sudo sed -i '/^\[/h;G;/P25/s/\(ModeHang=\).*/\1'"$7"'/m;P;d'  /etc/mmdvmhost
        sudo sed -i '/^\[/h;G;/P25 Network/s/\(ModeHang=\).*/\1'"$8"'/m;P;d'  /etc/mmdvmhost

        sudo sed -i '/^\[/h;G;/NXDN/s/\(ModeHang=\).*/\1'"$9"'/m;P;d'  /etc/mmdvmhost
        sudo sed -i '/^\[/h;G;/NXDN Network/s/\(ModeHang=\).*/\1'"$10"'/m;P;d'  /etc/mmdvmhost

        sudo sed -i '/^\[/h;G;/M17/s/\(ModeHang=\).*/\1'"$11"'/m;P;d'  /etc/mmdvmhost
        sudo sed -i '/^\[/h;G;/M17 Network/s/\(ModeHang=\).*/\1'"$12"'/m;P;d'  /etc/mmdvmhost

 sudo mount -o remount,ro /
