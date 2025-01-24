#!/bin/bash
#################################################
#  Get Last Heard Liost from MMDVMHost Log	#
#						#
#						#
#  VE3RD 			2020-05-03	#
#################################################
set -o errexit
set -o pipefail
sudo mount -o remount,rw /

if [ -f /home/pi-star/lh2_start.txt ]; then
  rm /home/pi-star/lh2_start.txt
fi
if [ -f /home/pi-star/lhlog.txt ]; then
  rm /home/pi-star/lhlog.txt
fi

echo "Args = $@" >> /home/pi-star/lh2_start.txt

name=""

declare -i n
####################################################
function domode2
{
line3=""
call1=""
name=""
while read -r line
do
	call=$(echo "$line" | cut -d' ' -f3)

	tm=$(echo "$line" | cut -d' ' -f2)
	dt=$(echo "$line" | cut -d' ' -f1)
	pl=$(echo "$line" | cut -d' ' -f5)

	echo "Add Call: $call" >> /home/pi-star/lh2_start.txt
	dataline=$(sudo sed -n "/$call/p" /usr/local/etc/stripped.csv)
       	did=$(echo "$dataline" | cut -d',' -f1 | head -1)
        call1=$(echo "$dataline" | cut -d',' -f2 | head -1)

        name=$(echo "$dataline" | cut -d',' -f3 | head -1)
        city=$(echo "$dataline" | cut -d',' -f4 | head -1)
        prov=$(echo "$dataline" | cut -d',' -f5 | head -1)
        country=$(echo "$dataline" | cut -d',' -f7 | head -1)

	if [ -z "$name" ]; then
		name="Name N/A"
	fi


#	line3=$(echo  "$dt" "$tm" "$call" "$name" | awk '{printf  "%5s %s %s %s|\n", $1 $2 $3 $name}')
	line3=""
	echo  "$dt $tm $call $name |" |  tr -d "\n"
#	echo "$line2"
#	line4=${line3:0:37}
	line6=$(echo "$line3" | tr -d "\n")

	list5+="$line6"
done <<< "$list9"

var="${list5:0:400}"
#echo "${var}"
echo "${var}" >> ./lh2_start.txt

}


######################################
#Start of Main Program
######################################

f1=$(ls -tr /var/log/pi-star/MMDVM* | tail -1)
list1=$(sudo sed -n '/received network end of voice transmission from/p' $f1 | sed 's/,//g' | sort -r -k14,14 -k2,3)

#echo "$list1"
list3=$(echo "$list1" | awk '$14!=savestr {print substr($2,6,5),substr($3,0,6),$14,$17,$6,$18,$20; savestr=$14}' | sort -r -k1,2 | tail -8)


lcnt=$(echo "$list3" | wc -l)
if [ $lcnt -lt 20 ]; then
	list3+=$list4
fi
#  echo "Test1234 | Test 2345 | TestTest\r |12345678"

#echo "$list3"

#echo "$list3" | sed -n '1,8p;9q' |  awk '{printf "%5s %5s %7s %6s %1s %4s %-4s|\n", $1, $2, $3, $4, $5, $6, $7}' | tr -d "\n | tail -8"
list9=$(echo "$list3" | sed -n '1,6p;7q' | awk '{print $1, $2, $3, $4}' )
	domode2

sudo mount -o remount,ro /
