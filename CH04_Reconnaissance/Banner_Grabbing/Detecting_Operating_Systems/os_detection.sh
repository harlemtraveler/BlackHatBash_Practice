#!/bin/bash

HOSTS="$*"

# Check if effective user's ID has root privileges (root EUID = 0).
if [[ "${EUID}" -ne 0 ]]; then
	echo "The Nmap OS detection scan type (-O) requires root privileges."
	exit 1
fi

# Check if user passed any parameters
if [[ "$#" -eq 0 ]]; then
	echo "You must pass an IP or IP range."
	exit 1
fi

echo "Running an OS detection Scan against ${HOSTS}..."

# Run nmap scan with OS detection using "-O" flag and store in "nmap_scan" variable.
nmap_scan=$(sudo nmap -O "${HOSTS}" -oG -)

# Loop through each line of nmap scan results and parse out info.
while read -r line; do
	ip=$(echo "${line}" | awk '{print $2}')
	os=$(echo "${line}" | awk -F'OS: ' '{print $2}' | sed 's/Seq.*//g')

	if [[ -n "${ip}" ]] && [[ -n "${os}" ]]; then
		echo "IP: ${ip} OS: ${os}"
	fi
done <<< "${nmap_scan}"
