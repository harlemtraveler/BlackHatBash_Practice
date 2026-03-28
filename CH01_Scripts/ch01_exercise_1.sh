#!/bin/bash

# STEP 1:
# Accept two argumentss on command line and assign them to variables.
# The first argument is the user's firstname, and second argument the lastname.

# Use positional arguments
FIRSTNAME="${1}"
LASTNAME="${2}"

# STEP 2:
# Create a new file named output.txt
echo "Creating a new file named output.txt..."
touch output.txt

# STEP 3:
# Write the current date to output.txt (bonus for DD-MM-YYYY format)
echo "Writing the current date to output.txt in DD-MM-YYYY format..."
date +%d-%m-%Y > output.txt

# STEP 4:
# Write your full name to output.txt
echo "Writing your full name to output.txt..."
echo "${FIRSTNAME} ${LASTNAME}" >> output.txt

# STEP 5:
# Make a backup copy of output.txt named backup.txt
echo "Backing up output.txt to a new file named backup.txt..."
cp output.txt ./backup.txt

# STEP 6:
# Print the content of the output.txt file to the standard output stream
echo "Printing the contents of output.txt..."
cat output.txt
