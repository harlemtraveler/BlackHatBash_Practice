#!/bin/bash

# Generate IP addresses from a given range.
for ip in $(seq 1 254); do
	echo "172.16.10.${ip}" >> 172-16-10-hosts.txt
done

# Alternative 1 - Use echo with brace expansion:
# echo 10.1.0.{1..254}

# Alternative 2 - echo, brace expansion, and sed (Stream Editor) to replace space with new lines:
# echo 10.1.0.{1..254} | sed 's/ /\n/g'

# Alternative 3 - Use printf format specifier (%s, %d, %f) with brach expansion. 
# Here we use an integer specifier (%d) as a placeholder and insert a new line (\n):
# printf "10.1.0.%d\n" {1..254}
