#!/bin/bash

# Pass a hosts file and port as Positional Args
FILE="${1}"
PORT="${2}"

# Check if two arguments were passed on the command line.
if [[ "$#" -ne 2 ]]; then
	echo "Usage: ${0} <file> <port>"
	exit 1
fi

# Check if file provided by the user exists on disk.
if [[ ! -f "${FILE}" ]]; then
	echo "File: ${FILE} was not found."
	exit 1
fi

# Check if port provided by the user is a number.
if [[ ! "${PORT}" =~ ^[0-9]+$ ]]; then
	echo "${PORT} must be a number."
	exit 1
fi

# Read hosts file line-by-line and run netcat on given port for each.
while read -r ip; do
	echo "Running netcat on ${ip}:${PORT}"
	result=$(echo -e "\n" | nc -v "${ip}" -w 1 "${PORT}" 2> /dev/null)

	# Check if result is not empty, then print IP and data.
	if [[ -n "${result}" ]]; then
		echo "==================="
		echo "+ IP Address: ${ip}"
		echo "+ Banner: ${result}"
		echo "==================="
	fi
done < "${FILE}"
