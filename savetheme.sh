#!/bin/bash
############################################################
#  Save Color Theme                                        #
#  Support code 0-9                                        #
#                                                          #
#                                                          #
#                                                          #
#  KF6S                                         05-07-2020 #
############################################################
set -o errexit
set -o pipefail

#!/bin/bash
############################################################
#   Set one mode Colors on Colors.ini                      #
#  						           #
#  						           #
#  VE3RD                                        2024-12-24 #
############################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

Mode="$1"
Theme="$2"
Split="$3"
Color="$4"

#sn=$(sed -nr "/^\['"Mode"']/ { :1 /^Set[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/Colors.ini)

sudo sed -i '/^\[/h;G;/'"$Mode"'/s/\(Theme=\).*/\1'"$2"'/m;P;d'  /etc/ColorThemes.ini
sudo sed -i '/^\[/h;G;/'"$Mode"'/s/\(Split=\).*/\1'"$3"'/m;P;d'  /etc/ColorThemes.ini
sudo sed -i '/^\[/h;G;/'"$Mode"'/s/\(Color=\).*/\1'"$4"'/m;P;d'  /etc/ColorThemes.ini


sudo mount -o remount,ro /

exit





if [ "$1" = 0 ]; then
sudo rm -f /usr/local/etc/Nextion_Support/ColorTheme.txt
sudo echo "Original" >> /usr/local/etc/Nextion_Support/ColorTheme.txt
fi

if [ "$1" = 1 ]; then
sudo rm -f /usr/local/etc/Nextion_Support/ColorTheme.txt
sudo echo "Black" >> /usr/local/etc/Nextion_Support/ColorTheme.txt
fi

if [ "$1" = 2 ]; then
sudo rm -f /usr/local/etc/Nextion_Support/ColorTheme.txt
sudo echo "Green" >> /usr/local/etc/Nextion_Support/ColorTheme.txt
fi

if [ "$1" = 3 ]; then
sudo rm -f /usr/local/etc/Nextion_Support/ColorTheme.txt
sudo echo "Yellow" >> /usr/local/etc/Nextion_Support/ColorTheme.txt
fi

if [ "$1" = 4 ]; then
sudo rm -f /usr/local/etc/Nextion_Support/ColorTheme.txt
sudo echo "Blue" >> /usr/local/etc/Nextion_Support/ColorTheme.txt
fi

if [ "$1" = 5 ]; then
sudo rm -f /usr/local/etc/Nextion_Support/ColorTheme.txt
sudo echo "Red" >> /usr/local/etc/Nextion_Support/ColorTheme.txt
fi

if [ "$1" = 6 ]; then
sudo rm -f /usr/local/etc/Nextion_Support/ColorTheme.txt
sudo echo "Custom6" >> /usr/local/etc/Nextion_Support/ColorTheme.txt
fi

if [ "$1" = 7 ]; then
sudo rm -f /usr/local/etc/Nextion_Support/ColorTheme.txt
sudo echo "Custom7" >> /usr/local/etc/Nextion_Support/ColorTheme.txt
fi

if [ "$1" = 8 ]; then
sudo rm -f /usr/local/etc/Nextion_Support/ColorTheme.txt
sudo echo "Custom8" >> /usr/local/etc/Nextion_Support/ColorTheme.txt
fi

if [ "$1" = 9 ]; then
sudo rm -f /usr/local/etc/Nextion_Support/ColorTheme.txt
sudo echo "Custom9" >> /usr/local/etc/Nextion_Support/ColorTheme.txt
fi
