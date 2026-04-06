#!/bin/bash
FILE="${1}"

while read -r host; do
    if ping -c 1 -W 1 -w 1 "${host}" &> /dev/null; then
        echo "${host} is up."
    fi
done < "${FILE}"


# ***NMAP***
#
# Alternative 1 - Use nmap
# nmap -sn 172.16.10.0/24

# Alternative 2 - Use nmap with grep and awk.
# 	1. nmap performs the network scan.
# 	2. grep filters line from the stream the start with "Nmap scan".
# 	3. awk changes the default delimeter from empty space (" ") to "report for ", then returns the second field.
# nmap -sn 172.16.10.0/24 | grep "Nmap scan" | awk -F'report for ' '{print $2}'


# ***ARP-SCAN***
#
# Use arp-scan to find new hosts on a network and obtain MAC addresses.
# The arp-scan utility can only be used locally and requires root permissions.

# Basic arp-scan against a single IP, specifying the interface with the "-I" flag:
# sudo arp-scan 172.16.10.10 -I br_public

# Use arp-scan against an entire network by passing a CIDR range:
# sudo arp-scan 172.16.10.0/24 -I br_public

# Use arp-scan against a target list by passing a file. 
# (NOTE: If file read permissions issue occurs, copy file to the /tmp/ dir)
# sudo arp-scan -f target-host-list.txt -I br_public
