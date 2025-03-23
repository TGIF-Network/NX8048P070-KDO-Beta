#!/bin/bash
##############################################################
# Support for Nextion Screen to create basic wpa_supplicant  #
# file in Nextion_Support directory.                         #
#                                                            #
# $1 is ssid and $2 is pre-shared key.                       #
# If $1 does not exist then will return hostname for AP mode #
# If $2 does not exist then will return default raspberry    #
#                                                            #
# KF6S                                            07-04-2019 #
##############################################################

WPA_FILE="/etc/wpa_supplicant/wpa_supplicant.conf"

# Check if script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root (using sudo)"
    exit 1
fi
echo "Starting"
sudo mount -o remount,rw /
sleep 1s
dirn="/etc/wifiprofiles.ini"

m11=$(sed -nr "/^\[Profile0\]/ { :l /^ssid[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
m12=$(sed -nr "/^\[Profile0\]/ { :l /^password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
m13=$(sed -nr "/^\[Profile0\]/ { :l /^priority[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
echo "$m11"
m21=$(sed -nr "/^\[Profile1\]/ { :l /^ssid[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
m22=$(sed -nr "/^\[Profile1\]/ { :l /^password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
m23=$(sed -nr "/^\[Profile\]/ { :l /^priority[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)

m31=$(sed -nr "/^\[Profile2\]/ { :l /^ssid[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
m32=$(sed -nr "/^\[Profile2\]/ { :l /^password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
m33=$(sed -nr "/^\[Profile2\]/ { :l /^priority[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)

m41=$(sed -nr "/^\[Profile3\]/ { :l /^ssid[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
m42=$(sed -nr "/^\[Profile3\]/ { :l /^password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
m43=$(sed -nr "/^\[Profile3\]/ { :l /^priority[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
echo "$m11"

m51=$(sed -nr "/^\[Profile4\]/ { :l /^ssid[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
m52=$(sed -nr "/^\[Profile4\]/ { :l /^password[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
m53=$(sed -nr "/^\[Profile4\]/ { :l /^priority[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" $dirn)
echo "$m11"

# Create the configuration file
cat > "$WPA_FILE" << EOL
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
ap_scan=1
fast_reauth=1
country=US

network={
	ssid="$m11"
	psk="$m12"
	key_mgmt=WPA-PSK
	id_str="0"
	priority=90
	scan_ssid=1
}

network={
	ssid="$m21"
	psk="$m22"
	key_mgmt=WPA-PSK
	id_str="1"
	priority=80
	scan_ssid=1
}
network={
	ssid="$m31"
	psk="$m32"
	key_mgmt=WPA-PSK
	id_str="2"
	priority=70
	scan_ssid=1
}
network={
	ssid="$m41"
	psk="$m42"
	key_mgmt=WPA-PSK
	id_str="3"
	priority=60
	scan_ssid=1
}
network={
	ssid="$m51"
	psk="$m52"
	key_mgmt=WPA-PSK
	id_str="4"
	priority=50
	scan_ssid=1
}
EOL


status=$?
if test $status -eq 0
then
echo "Supplicant file was created!"
else
echo "Supplicant file was not created!"
fi


sudo mount -o remount,ro /

