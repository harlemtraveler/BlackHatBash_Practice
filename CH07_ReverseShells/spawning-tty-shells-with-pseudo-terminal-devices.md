# Spawning TTY Shells with Pseudo-terminal Devices
**Chapter** 7 &emsp;|&emsp; **Page** 154

A scenario you may encounter is that the limited shell you have access to may not provide full 
TTY (Teletypewriter, or teletype) terminal support. Non-TTY shells have limited command line editing,
no job control, incomplete output formatting, and missing signal handling, and they may not work in
interactive applications such as text editors.

<br>
<br>

A common approach to upgrade shell to a feature-rich TTY is by using pseudo-terminals (PTY). What a pseudo-terminal
does is provide an interface through which processes can interact with a terminal-like device, allowing
terminal-based applications, shells and other programs to operate as if they're connected to a physical terminal.

<br>
<br>

## Python's pty Module
Python's *pty* module emulates the functionality of a physical terminal device. In the example below, we upgrade
a Python shell to a fully interactive TTY bash shell using the `pty.spawn()` function:
```
──(kali㉿kali)-[~]
└─$ python

Python 3.13.12 (main, Feb  4 2026, 15:06:39) [GCC 15.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import pty
>>> pty.spawn("/bin/bash")
┌──(kali㉿kali)-[~]
└─$ 

```

To exit the python console, enter `exit()`.

<br>
<br>

On a compromised host with Python installed, you could elevate your shell with the following command:
```
python3 -c 'import pty; pty.spawn("/bin/bash")'
```

> ### **NOTE**
> Python MUST be installed & available on the compromised host machine for this technique to work.

<br>
<br>

## Socat
You can use *socat* to spawn TTY shells if the tool is available on **BOTH** the target and the attacking machine.
Socat is generally used for bidirectional communication between two data channels.

<br>
<br>

For example, run the following socat command on your attacking Kali machine to spawn a TTY shell:
```
socat file:$(tty),raw,echo=0 tcp-listen:1337
```

- The `file:` parameter uses the value of the `$(tty)` command, which expands to `/dev/pts/#`.
- `raw`, or Raw mode, ensures that socat won't process input and output data.
- `echo=0` disables socats local echoing.
- `tcp-listen:1337` defines the local TCP listening port.

<br>
<br>
