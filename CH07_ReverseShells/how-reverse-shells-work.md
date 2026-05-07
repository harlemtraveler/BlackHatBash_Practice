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
