#!/bin/bash
############################################################
#  Get Cross Mode                                          #
#                                                          #
#  Returns a string of | separated variables               #
#                                                          #
#  VE3RD                                        2025-01-21 #
############################################################
set -o errexit
set -o pipefail

#Order
#YSF2DMR
#YSF2NXDN
#YSF2P25

#DMR2YSF
#DMR2NXDN
#


m1=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
m2=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2nxdn)
m3=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2p25)
m4=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmr2ysf)
m5=$(sed -nr "/^\[Enabled\]/ { :1 /^Enabled[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmr2nxdn)

 
t1=$(sed -nr "/^\[DMR Network\]/ { :1 /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
t2=$(sed -nr "/^\[NXDN Network\]/ { :1 /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2nxdn)
t3=$(sed -nr "/^\[P25 Network\]/ { :1 /^StartupDstId[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2p25)
t4=$(sed -nr "/^\[DMR Network\]/ { :1 /^DefaultDstTG[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmr2ysf)
t5=$(sed -nr "/^\[Network\]/ { :1 /^Static[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/nxdngateway)


n1=$(sed -nr "/^\[DMR Network\]/ { :1 /^Address[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/ysf2dmr)
n2=$(sed -nr "/^\[Network\]/ { :1 /^Static[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/nxdngateway)
n3=$(sed -nr "/^\[Network\]/ { :1 /^Static[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/p25gateway)
n4=$(sed -nr "/^\[DMR Network\]/ { :1 /^DefaultDstTG[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b 1;}" /etc/dmr2ysf)
n5="na"

mt="$m1|$m2|$m3|$m4|$m5|$t1|$t2|$t3|$t4|$t5|$n1|$n2|$n3|$n4|$n5"
echo "$mt"
exit


# grep 32592 /usr/local/etc/YSFHosts.txt
n2=$(sed -r '/^'"$t2"'\t|shared/!d' /usr/local/etc/NXDN*.txt | cut -f2)
echo "Test n2 $n2"
n3=$(sed -r '/^'"$t3"'\t|shared/!d' /usr/local/etc/P25*.txt | cut -f2)
echo "Test n3 $m3"
n4=$(sed -r '/^'"$t4"'\t|shared/!d' /usr/local/etc/YSFHo*.txt | cut -d ";" -f2)
echo "Test n4 $n4"
echo "Test t4-n4 $t4 $n4 "

n4=$(grep "$t4" /usr/local/etc/YSF* | cut -d ";" -f2 | head -1)
echo "Test n4-2 $n4"
echo "Test n4-2 $n4"

n5=$(sed -r '/^'"$t5"'\t|shared/!d' /usr/local/etc/NXDN*.txt | cut -f2)

echo "Test n5 $n5"
mt="$m1|$m2|$m3|$m4|$m5|$t1|$t2|$t3|$t4|$t5|$n1|$n2|$n3|$n4|$n5"

echo "$mt"
#echo "$tt"
#echo "$nt"


