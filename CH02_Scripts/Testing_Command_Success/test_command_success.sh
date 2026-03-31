#!/bin/bash

FILE_NAME="test123.txt"

# Test if command succeeded
if touch "${FILE_NAME}"; then
	echo "OK: file ${FILE_NAME} was created"
fi

# Test if command failed
if ! touch "${FILE_NAME}"; then
	echo "FAIL: file ${FILE_NAME} creation failed"
fi
