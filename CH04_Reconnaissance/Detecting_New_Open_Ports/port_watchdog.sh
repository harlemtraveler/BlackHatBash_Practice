#!/bin/bash

# IP and target port passed in as args (Example: ./port_watchdog.sh 127.0.0.1 80).
LOG_FILE="watchdog.log"
IP_ADDRESS="${1}"
WATCHED_PORT="${2}"

# Takes IP and port from passed in args, then runs nmap scan.
service_discovery() {
	local host
	local port
	host="${1}"
	port="${2}"

	nmap -sV -p "${port}" "${host}" >> "${LOG_FILE}"
}

# Start infinite loop running Rustscan against IP and port (-g flag for greppable).
while true; do
	port_scan=$(docker run --network=host -it --rm \
		--name rustscan rustscan/rustscan:2.1.1 \
		-a "${IP_ADDRESS}" -g -p "${WATCHED_PORT}")

	# If scan result is not empty, pass IP and port to service_discovery function.
	if [[ -n "${port_scan}" ]]; then
		echo "${IP_ADDRESS} has started responding on port ${WATCHED_PORT}!"
		echo "Performing a service discovery..."

		# Run service_discovery func and write results to logfile.
		if service_discovery "${IP_ADDRESS}" "${WATCHED_PORT}"; then
			echo "Wrote port scan data to ${LOG_FILE}"
			break
		fi
	else
		echo "Port is not yet open, sleeping for 5 seconds..."
		sleep 5
	fi
done
