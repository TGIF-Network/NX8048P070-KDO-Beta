#!/bin/bash
############################################################
#  Get ALL  ModeHangs from /etc/mmdvmhost                  #
#                                                          #
#                                                          #
# VE3RD                                       2025-01-19   #
############################################################
set -o errexit
set -o pipefail


 m1=$(sed -n '/^[ \t]*\[D-Star\]/,/\[/s/^[ \ModeHang[ \t]*=[ \t]*//p' /etc/mmdvmhost)
 m2=$(sed -n '/^[ \t]*\[D-Star Network\]/,/\[/s/^[ \ModeHang[ \t]*=[ \t]*//p' /etc/mmdvmhost)
 m3=$(sed -n '/^[ \t]*\[DMR\]/,/\[/s/^[ \ModeHang[ \t]*=[ \t]*//p' /etc/mmdvmhost)
 m4=$(sed -n '/^[ \t]*\[DMR Network\]/,/\[/s/^[ \ModeHang[ \t]*=[ \t]*//p' /etc/mmdvmhost)
 m5=$(sed -n '/^[ \t]*\[System Fusion\]/,/\[/s/^[ \ModeHang[ \t]*=[ \t]*//p' /etc/mmdvmhost)
 m6=$(sed -n '/^[ \t]*\[System Fusion Network\]/,/\[/s/^[ \ModeHang[ \t]*=[ \t]*//p' /etc/mmdvmhost)
 m7=$(sed -n '/^[ \t]*\[P25\]/,/\[/s/^[ \ModeHang[ \t]*=[ \t]*//p' /etc/mmdvmhost)
 m8=$(sed -n '/^[ \t]*\[P25 Network\]/,/\[/s/^[ \ModeHang[ \t]*=[ \t]*//p' /etc/mmdvmhost)
 m9=$(sed -n '/^[ \t]*\[NXDN\]/,/\[/s/^[ \ModeHang[ \t]*=[ \t]*//p' /etc/mmdvmhost)
 m10=$(sed -n '/^[ \t]*\[NXDN Network\]/,/\[/s/^[ \ModeHang[ \t]*=[ \t]*//p' /etc/mmdvmhost)
 m11=$(sed -n '/^[ \t]*\[M17\]/,/\[/s/^[ \ModeHang[ \t]*=[ \t]*//p' /etc/mmdvmhost)
 m12=$(sed -n '/^[ \t]*\[M17 Network\]/,/\[/s/^[ \ModeHang[ \t]*=[ \t]*//p' /etc/mmdvmhost)
 echo "$m1|$m2|$m3|$m4|$m5|$m6|$m7|$m8|$m9|$m10|$m11|$m12"
