#!/bin/bash

# The "$@" variable gets all positional arguments, each individually quoted.
echo "The arguments are: $@"

# The "$*" variable gets all positional arguments, expanded into a single word.
echo "The arguments concanted are: $*"

# The "$#" variable gets the total number of passed positional arguments.
echo "The total number of arguments is: $#"
