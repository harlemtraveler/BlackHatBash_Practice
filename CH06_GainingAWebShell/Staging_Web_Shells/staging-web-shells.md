# Staging Web Shells
**Chapter**: 6 &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp; **Page**: 128

To successfully pop a shell, it may involve technical considerations beyond exploiting a file upload vulnerability.<br>
Consider the following factors when staging a web shell:
* **Execution Context**
* **Filepath and Location**
* **Access Controls and Authorization**
* **Web Application Firewalls** 

### Execution Context
Consider the target's programming language, server configuration, and execution environment.<br>
As an example, if a application runs on Python, ensure the web shell code is compatible with Python syntax.<br>
If the application runs on PHP, ensure the web shell code is compatible with PHP syntax.

### Filepath and Location
Determine the appropriate filepath and location for the web shell by considering the target application's directory structure, access controls, and file inclusion mechanisms.<br>
Identify writable directories and locations at which the web shell can be stored and executed effectively.<br>
For example, you might be able to upload non-image filepaths such as */uploads*, */files*, or */static*; and images to */images* or */img*.<br>
There is no single standard and files can live anywhere the developer desires. Identifying the application's root directory also helps.<br>
As an example, websites are commonly stored at */var/www/html* on a web server.


### Access Controls and Authorization
Consider any access controls, authentication mechanisms, or user roles implemented in the application.<br>
Exploiting vulnerabilities related to user roles, privilege escalation, or authentication can provide additional opportunities for successful web shell staging.<br>
For example, you may be required to authenticate in order to upload a file even if the file is then accessible to unauthenticated users.

### Web Application Firewalls
Security systems such as web application firewalls could detect attempts to upload commonly used web shells.<br>
They could also identify attempts to execute system commands via HTTP parameters.<br>
So, using popular web shells like *c99.php* or *b374k* may increase your chances of getting caught and blocked.<br>
Other security systems, such as endpoint detection and response, may observe system process activity.<br>
If they detect a web server process attempting to run shell commands, they may raise alarms or block the execution all together.


## Finding Directory Traversal Vulnerabilities
