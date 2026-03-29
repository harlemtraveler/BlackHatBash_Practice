#!/bin/bash

FILENAME="flow_control_with_if.txt"

if [[ -f "${FILENAME}" ]]; then
	echo "${FILENAME} already exists."
	exit 1
else
	touch "${FILENAME}"
fi

# Alternative method using the NOT (!) operator:
#if [[ ! -f "${FILENAME}" ]]; then
#	touch "${FILENAME}"
#fi
