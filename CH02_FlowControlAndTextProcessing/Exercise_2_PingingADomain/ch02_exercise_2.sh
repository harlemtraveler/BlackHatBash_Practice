#!/bin/bash

NAME="${1}"
TARGET_DOMAIN="${2}"
OUTPUT_FILE="results.csv"

# Check if arguments were supplied
if [[ -z ${NAME} ]] || [[ -z ${TARGET_DOMAIN} ]]; then
	echo "[!] Missing arguement(s). Please provide two arguements: SCRIPT_NAME and TARGET_DOMAIN"
	echo "Example: ${0} mysite nostarch.com"
	exit 1
else
	echo "[+] Executing script..."
fi

# Write CSV header to the file
echo "status,name,domain,timestamp" > "${OUTPUT_FILE}"

# Ping domain
if ping -c 1 "${TARGET_DOMAIN}" &> /dev/null; then
	echo "Success,${NAME},${TARGET_DOMAIN},$(date)" >> "${OUTPUT_FILE}"
else
	echo "Failure,${NAME},${TARGET_DOMAIN},$date()" >> "${OUTPUT_FILE}"
fi
