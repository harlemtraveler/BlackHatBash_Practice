#!/bin/bash

# Sets an array
IP_ADDRESSES=(192.168.1.1 192.168.1.2 192.168.1.3)

# Removes the second element from the array
#unset IP_ADDRESSES[1]

# Swap/reassign the first element in the array for a new value
IP_ADDRESSES[0]="192.168.1.10"

# Prints all elements in the array
echo "${IP_ADDRESSES[*]}"

# Prints only the first element in the array
echo "${IP_ADDRESSES[0]}"
