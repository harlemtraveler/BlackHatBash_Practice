#!/bin/bash

# Creates a 'global' variable scoped to the file.
PUBLISHER="No Starch Press"

# Creates a local variable scoped to the function.
print_name(){
	local name
	name="Black Hat Bash"
	echo "${name} by ${PUBLISHER}"
}

print_name

echo "Variable ${name} will not be printed because it is a local variable"
