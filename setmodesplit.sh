#!/bin/bash
############################################################
#  Save Mode Colors Splits to /etc/ColorThemes.ini         #
#                                                          #
#                                                          #
#                                                          #
#  VE3RD                                        2025-01-17 #
############################################################
set -o errexit
set -o pipefail

sudo mount -o remount,rw /

sudo sed -i '/^\[/h;G;/MMDVM/s/\(Split=\).*/\1'"$1"'/m;P;d'  /etc/ColorThemes.ini
sudo sed -i '/^\[/h;G;/DMR/s/\(Split=\).*/\1'"$2"'/m;P;d'  /etc/ColorThemes.ini
sudo sed -i '/^\[/h;G;/YSF/s/\(Split=\).*/\1'"$3"'/m;P;d'  /etc/ColorThemes.ini
sudo sed -i '/^\[/h;G;/NXDN/s/\(Split=\).*/\1'"$4"'/m;P;d'  /etc/ColorThemes.ini
sudo sed -i '/^\[/h;G;/P25/s/\(Split=\).*/\1'"$5"'/m;P;d'  /etc/ColorThemes.ini
sudo sed -i '/^\[/h;G;/D-Star/s/\(Split=\).*/\1'"$6"'/m;P;d'  /etc/ColorThemes.ini
sudo sed -i '/^\[/h;G;/M17/s/\(Split=\).*/\1'"$7"'/m;P;d'  /etc/ColorThemes.ini


sudo mount -o remount,ro /


