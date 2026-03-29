#!/bin/bash

# We run a for loop on the output of commands such as "ls"
# here, "ls ." list the files in the current directory and iterates over the output.
for file in $(ls .); do
	echo "File: ${file}"
done
