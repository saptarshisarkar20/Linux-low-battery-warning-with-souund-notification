#!/bin/bash

sleep 10
while :
do
	while read line
	do
		value=$(echo $line | sed 's/%//g' | cut -d " " -f 2)
		key=$(echo $line | sed 's/%//g' | cut -d ":" -f 1)

		if [ $key = 'state' ]
		then
			bat_state=$value
		else
			bat_percent=$value
		fi
	done < <(upower -i `upower -e | grep BAT` | grep -E "percentage|state")

	echo $bat_state
	echo $bat_percent

	if [ $bat_state = 'discharging' ]
	then
		if [ $bat_percent -lt 30 ]
		then
			notify-send "Battery Warning !!!!!!!!!!!!!!!!!" "Saptarshi, your battery is running low, Please Charge!"
			espeak "Saptarshi, Battery is Low, Please connect the charger" - s 140
		fi
	fi
	sleep 300
done