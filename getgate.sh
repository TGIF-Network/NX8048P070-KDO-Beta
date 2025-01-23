#!/bin/bash
############################################################
#  Get  Network Detail from /etc/dmrgateway                #
#                                                          #
#  Returns the status Binary Coded Value                   #
#                                                          #
#  VE3RD                                      2019-11-14   #
############################################################
set -o errexit
set -o pipefail

	wl=$(sudo sed -n '/^[ \t]*\[DMR\]/,/\[/s/^[ \t]*WhiteList[ \t]*=[ \t]*//p' /etc/mmdvmhost)

	if [ -z "$1" ]; then
        	df="1"
	fi

	gwa=$(sudo sed -n '/^[ \t]*\[DMR Network\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/mmdvmhost)


	if [ "$1" = "0" ]; then
		if [ "$gwa" = "127.0.0.1" ]; then
			gw="1"
		else
			gw="0"
		fi
		echo "$gw|$gwa|$wl"
	fi

	if [ "$1" = "1" ]; then
		m1=$(sudo sed -n '/^[ \t]*\[DMR Network 1\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
		m2=$(sudo sed -n '/^[ \t]*\[DMR Network 2\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
		m3=$(sudo sed -n '/^[ \t]*\[DMR Network 3\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
		m4=$(sudo sed -n '/^[ \t]*\[DMR Network 4\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
		m5=$(sudo sed -n '/^[ \t]*\[DMR Network 5\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
		m6=$(sudo sed -n '/^[ \t]*\[DMR Network 6\]/,/\[/s/^[ \t]*Enabled[ \t]*=[ \t]*//p' /etc/dmrgateway)
		mt="$gw|$m1|$m2|$m3|$m4|$m5|$m6"
		echo "$mt"
	fi
        if [ "$1" = "3" ]; then
                m1=$(sudo sed -n '/^[ \t]*\[DMR Network 1\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m2=$(sudo sed -n '/^[ \t]*\[DMR Network 2\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m3=$(sudo sed -n '/^[ \t]*\[DMR Network 3\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m4=$(sudo sed -n '/^[ \t]*\[DMR Network 4\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m5=$(sudo sed -n '/^[ \t]*\[DMR Network 5\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m6=$(sudo sed -n '/^[ \t]*\[DMR Network 6\]/,/\[/s/^[ \t]*Name[ \t]*=[ \t]*//p' /etc/dmrgateway)
                if [ -z $m4 ]; then
                        m13=na
                fi
                if [ -z $m5 ]; then
                        m14=na
                fi

                mts="$gw|$m1|$m2|$m3|$m4|$m5|$m6"
                echo "$mts"
        fi
       
        if [ "$1" = "2" ]; then
                m1=$(sudo sed -n '/^[ \t]*\[DMR Network 1\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m2=$(sudo sed -n '/^[ \t]*\[DMR Network 2\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m3=$(sudo sed -n '/^[ \t]*\[DMR Network 3\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m4=$(sudo sed -n '/^[ \t]*\[DMR Network 4\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m5=$(sudo sed -n '/^[ \t]*\[DMR Network 5\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
                m6=$(sudo sed -n '/^[ \t]*\[DMR Network 6\]/,/\[/s/^[ \t]*Address[ \t]*=[ \t]*//p' /etc/dmrgateway)
                if [ -z $m4 ]; then
                        m13=na
                fi
                if [ -z $m5 ]; then
                        m14=na
                fi

                mts="$gw|$m1|$m2|$m3|$m4|$m5|$m6"
                echo "$mts"
        fi



