# How Reverse Shells Work
**Chapter** 7 &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp; **Page**: 144

Reverse shells are commonly used for post-exploitation activities.<br>
They provide attackers initial access to a target that is more stable than a web shell<br>
and maintains control over compromised machines without the need to directly connect to it.<br>
<br>
The term *reverse* references the direction of initial network traffic. With traditional shells,<br>
the attacker's machine is typically the one to initiate a connection to the compromised machine<br>
to issue commands and control it (*attacker-machine -> target-machine*). However, with reverse <br>
shells, the target machine is the one to initiate a connection with the attacker's machine <br>
(*target-machine -> attacker-machine*).

## Ingress vs. Egress Controls


## Shell Payloads and Listeners


## The Communication Sequence
##### The sequence of network communications involved in the use of reverse shells:
![Reverse Shell Diagram](./reverse-shell.svg)

### Creating a Reverse Shell Involves the Following Steps:
1. **Setting up a shell listener:** <br>
   - The attacker machine initializes a shell listener running on a specific port that is accessible from the internet.<br><br>
2. **Exploiting the target server:** <br>
   - The attacker compromises the target system through a vulnerability.<br><br>
3. **Uploading a reverse shell payload:** <br>
   - The attacker crafts a reverse shell payload and delivers it by exploiting the underlying vulnerability in the target system.<br><br>
4. **Executing the payload:** <br>
   - The payload is executed on the target server.<br><br>
5. **Requesting a reverse connection:** <br>
   - The payload attempts to connect to the attacker's machine, acting as the client.<br><br>
6. **Accepting the shell connection:** <br>
   - The listener receives the incoming connection and establishes a bidirectional communication channel with the target machine over the network.<br><br>
7. **Executing commands and gaining server control:** <br>
   - With the reverse shell connection established, the attacker gains control over the compromised target system and may execute shell commands remotely.
