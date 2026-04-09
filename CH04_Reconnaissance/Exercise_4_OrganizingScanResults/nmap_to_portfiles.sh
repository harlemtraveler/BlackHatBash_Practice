#!/bin/bash

HOSTS_FILE="${1}"
RESULT=$(nmap -iL ${HOSTS_FILE} --open | grep "Nmap scan report\|tcp open")

# Read the nmap output line by line
while read -r line; do
	if echo "${line}" | grep -q "report for"; then
		ip=$(echo "${line}" | awk -F'for ' '{print $2}')
	else
		port=$(echo ${line} | grep open | awk -F'/' '{print $1}')
		file="port-${port}.txt"
		echo "${ip}" >> "${file}"
	fi
done <<< "${RESULT}"

# Extra Challenge - create one-liner bash script that extracts the open ports from XML output:
# nmap -iL target-hosts.txt --open -oX - | grep "port protocol=\"tcp\"" | awk '{print $3}' | awk -F'><' '{print $1}' | awk -F'=' '{print $2}' | tr -d '"'