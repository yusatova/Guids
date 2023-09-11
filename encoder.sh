#!/bin/bash
#to read array echo ${esns_channells[0]}

#to get correct esn with the channels based on settings output and save it to the array 

mapfile -t esns_chanells < <(cd /opt/een/var/bridge/esns;
for i in */; do echo $i;for j in $i/settings; do python -m json.tool $j | 
grep -E "child_camera_view|parent_camera_id";done;done | grep -A1 -B1 "child") 


#to get current channels with guids and set it to array 

mapfile -t guids < <(cd /opt/een/var/bridge/cameras;
for i in */device_config;do  cat $i  |  grep -q Channel* && cat $i | strings |
awk '/Channel [0-9]+/ {channel=$0} /[0-9a-f-]{36}/ {print channel; print}';done)


#to compare Channels from esn and guid and assign that guid to the esn

