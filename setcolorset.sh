#!/bin/bash
############################################################
#   Set Colors on ColorThemes.ini                               #
#  						           #
#  						           #
#  VE3RD                                        2024-04-17 #
############################################################
set -o errexit
set -o pipefail
# Check all six modes and set each one to either 0 or 1

if [ -z "$5" ]; then
        exit
else
	sudo mount -o remount,rw /
	SetNum="$1"

	sudo sed -i '/^\[/h;G;/Theme'"$1"'/s/\(CB1=\).*/\1'"$2"'/m;P;d'  /etc/ColorThemes.ini
	sudo sed -i '/^\[/h;G;/Theme'"$1"'/s/\(CT1=\).*/\1'"$3"'/m;P;d'  /etc/ColorThemes.ini
	sudo sed -i '/^\[/h;G;/Theme'"$1"'/s/\(CB2=\).*/\1'"$4"'/m;P;d'  /etc/ColorThemes.ini
	sudo sed -i '/^\[/h;G;/Theme'"$1"'/s/\(CT2=\).*/\1'"$5"'/m;P;d'  /etc/ColorThemes.ini

	sudo mount -o remount,ro /

fi;
