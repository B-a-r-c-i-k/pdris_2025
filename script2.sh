#!/bin/bash

system_report() {
	timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
	date_only=$(date +"%Y-%m-%d")

	filename="system_report_${date_only}.csv"

	while true
	do
		current_date_only=$(date +"%Y-%m-%d")

		if [[ ! -f "system_report_${current_date_only}.csv" ]] 
		then
			date_only="$current_date_only"
			timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
			filename="system_report_${date_only}.csv"
		fi
		all_memory=$(free -h | grep Mem | awk '{print $2}')
		free_memory=$(free -h | grep Mem | awk '{print $4}')
		percent_usage_memory=$(free -h | grep Mem | awk '{print ($3/$2)*100}')
		percent_usage_cpu=$(top -bn1 | grep '^%Cpu' | awk '{print $2+$4}')
		disk_usage=$(df -h | grep /dev/sda2 | awk '{print $4}')
		load_1=$(uptime | awk '{print $9}')
		echo "$timestamp;$all_memory;$free_memory;$percent_usage_memory%;$percent_usage_cpu%;$disk_usage;$load_1" >> "$filename"
		sleep 10
	done
}

if [[ $1 == "START" ]] 
then
	if [[ $(pgrep -f "./script.sh START" | wc -l) > 2  ]]
	then
		echo "Already started"
	else
		system_report &
		echo "Running $!"	
	fi
elif [[ $1 == "STATUS" ]]
then
	if [[ $(pgrep -f "./script.sh START") ]]
	then
		echo "Executing"
	else
		echo "Not executing"
	fi
elif [[ $1 == "STOP" ]]
then
	kill $(pgrep -f "./script.sh START")
	echo "Stopped"
else
	echo "Wrong command"
fi

