#!/bin/bash
############################################################
#  Get ColorThemes Info from /etc/ColorThemes.ini      		   #
#                                                          #
#  Returns a Binary Coded Value                            #
#                                                          #
#  VE3RD                                      2024-04-17   #
############################################################
set -o errexit
set -o pipefail



if [ ! -z "$2" ]; then
	if [ "$2" = "MMDVM" ];  then
		m1=$(sed -n '/^[ \t]*\[MMDVM\]/,/\[/s/^[ \Theme[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
		spl=$(sed -n '/^[ \t]*\[MMDVM\]/,/\[/s/^[ \Split[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
	fi

	if [ "$2" = "DMR" ]; then
		m1=$(sed -n '/^[ \t]*\[DMR\]/,/\[/s/^[ \Theme[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
		spl=$(sed -n '/^[ \t]*\[DMR\]/,/\[/s/^[ \Split[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
	fi

	if [ "$2" = "YSF" ]; then
		m1=$(sed -n '/^[ \t]*\[YSF\]/,/\[/s/^[ \Theme[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
		spl=$(sed -n '/^[ \t]*\[YSF\]/,/\[/s/^[ \Split[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
	fi

	if [ "$2" == "P25" ]; then
		m1=$(sed -n '/^[ \t]*\[P25\]/,/\[/s/^[ \Theme[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
		spl=$(sed -n '/^[ \t]*\[P25\]/,/\[/s/^[ \Split[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
	fi

	if [ "$2" == "NXDN" ]; then
		m1=$(sed -n '/^[ \t]*\[NXDN\]/,/\[/s/^[ \Theme[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
		spl=$(sed -n '/^[ \t]*\[NXDN\]/,/\[/s/^[ \Split[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
	fi

	if [ "$2" == "D-Star" ]; then
		spl=$(sed -n '/^[ \t]*\[D-Star\]/,/\[/s/^[ \Split[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
		m1=$(sed -n '/^[ \t]*\[D-Star\]/,/\[/s/^[ \Theme[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
	fi

	if [ "$2" == "M17" ]; then
		m1=$(sed -n '/^[ \t]*\[M17\]/,/\[/s/^[ \Theme[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
		spl=$(sed -n '/^[ \t]*\[M17\]/,/\[/s/^[ \Split[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
	fi
	SetNum="$m1"
    else
	SetNum="$1"

    fi

m2=$(sed -n '/^[ \t]*\[Theme'$SetNum'\]/,/\[/s/^[ \t]*CB1[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
m3=$(sed -n '/^[ \t]*\[Theme'$SetNum'\]/,/\[/s/^[ \t]*CT1[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
m4=$(sed -n '/^[ \t]*\[Theme'$SetNum'\]/,/\[/s/^[ \t]*CB2[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)
m5=$(sed -n '/^[ \t]*\[Theme'$SetNum'\]/,/\[/s/^[ \t]*CT2[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)

#m0=$(sed -n '/^[ \t]*\[ColorSet'"$SetNum"'\]/,/\[/s/^[ \^Split[ \t]*=[ \t]*//p' /etc/ColorThemes.ini)

mt="$SetNum|$spl|NA|$m2|$m3|$m4|$m5"
echo "$mt"

