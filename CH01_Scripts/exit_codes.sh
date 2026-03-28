#!/bin/bash

# Experimenting with exit codes
# The special variable "$?" returns exit codes.
# "/dev/null" is a special device file that discards any data sent to it

ls -l > /dev/null
echo "The exit code of the ls command was: $?"

lzl 2> /dev/null
echo "The exit code of the non-existing lzl command was: $?"
