#!/bin/bash
############################################################
#  Save Mode Colors to /etc/ColorThemes.ini                #
#                                                          #
#                                                          #
#                                                          #
#  VE3RD                                        2025-01-16 #
############################################################
set -o errexit
set -o pipefail

sudo mount -o remount,rw /

Mode="$1"
Theme="$2"
Split="$3"

sudo sed -i '/^\[/h;G;/'"$Mode"'/s/\(Theme=\).*/\1'"$2"'/m;P;d'  /etc/ColorThemes.ini
sudo sed -i '/^\[/h;G;/'"$Mode"'/s/\(Split=\).*/\1'"$3"'/m;P;d'  /etc/ColorThemes.ini


sudo mount -o remount,ro /


