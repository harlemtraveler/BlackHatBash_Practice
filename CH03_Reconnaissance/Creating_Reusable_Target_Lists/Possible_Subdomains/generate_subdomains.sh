#!/bin/bash

DOMAIN="${1}"
FILE="${2}"

# Read the file from standard input and echo the full domain.
while read -r subdomain; do
    echo "${subdomain}.${DOMAIN}"
done < "${FILE}"

# Alternative - use sed (Sequence Editor) with end-of-line character ($)
# to append your apex domain to all items in subdomain wordlist:
# sed 's/$/.example.com/g' subdomains-1000.txt