#!/bin/bash

DEFAULT_PORT="80"

# Prompt user for target IP address and port number.
read -r -p "Type a target IP address: " ip
read -r -p "Type a target port (default: 80): " port

# Check if the user provided an IP address.
# NOTE: The "-z" test operator is True if length of string is zero.
if [[ -z "${ip}" ]]; then
	echo "You must provide an IP address."
	exit 1
fi

# Check if the user provided a specific port number.
if [[ -z "${port}" ]]; then
	echo "You did not provide a specific port, defaulting to ${DEFAULT_PORT}"
	port="${DEFAULT_PORT}"
fi

echo "Attempting to grab the Server header of ${ip}..."

# Run curl, grep for "Server", filter with awk, and store in the variable "result".
result=$(curl -s --head "${ip}":"${port}" | grep Server | awk -F':' '{print $2}')

echo "Server header for ${ip} on port ${port} is: ${result}"
