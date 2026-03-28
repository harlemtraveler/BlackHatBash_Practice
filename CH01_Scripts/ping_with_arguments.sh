#!/bin/bash

# This script will ping any address provided as an argument.

# The ${0} argument is the name of the script file itself.
SCRIPT_NAME="${0}"

# The ${1} positional argument is the first parameter passed to the script file.
TARGET="${1}"

echo "Running the script ${SCRIPT_NAME}..."
echo "Pinging the target: ${TARGET}..."
ping "${TARGET}"
