# Use Lsyncd For Ubuntu

You may need **Lsyncd** to remote real-time synchronization of data from two servers.

For example:

You want 172.22.237.1 to synchronize the data of 172.22.27.2 in real time.

## Pre Work

Make sure password free login between servers.

For example (You are now at 172.22.237.2):

```
ssh-keggen -t rsa
ssh-copy-id root@172.22.237.1
```

## Install Lsyncd

```apt-get install lsyncd```

## Configurate Lsyncd

##### You need to create a config file when you first use Lsyncd.

```touch /etc/lsyncd/lsyncd.conf.lua```

##### Also, log file and status file.

```
touch /var/log/lsyncd/lsyncd.log
touch /var/log/lsyncd/lsyncd.status
```

##### Then, edit lsyncd.lua

```vim /etc/lsyncd/lsyncd.conf.lua```

##### Format as the following:

```
settings  {
    logfile = "/var/log/lsyncd/lsyncd.log",
    statusFile = "/var/log/lsyncd/lsyncd.status",
    maxProcesses = 10
}

sync {
    default.rsyncssh,
    source = "/home/judge/data",
    host = "172.22.237.1",
    targetdir = "/home/judge/data",
    init = false,
    delay = 0,

    rsync = {
        binary    = "/usr/bin/rsync",
        archive  = true,
        compress  = true,
        verbose  = true
    },

    ssh = {
    	port  = 22
    }
}
```

##### Parameter description:

maxProcesses: Maximum number of synchronization processes

default.rsyncssh: Synchronize to the remote host directory. The SSH mode of Rsync requires key authentication.

source: Source directory of synchronization, using absolute path.

host: Target IP

 targetdir: Target directory

## Start Lsyncd

You need to enable root privileges.

```sudo -i```

Then start it

```
lsyncd -log Exec /etc/lsyncd/lsyncd.conf.lua
service lsyncd start
```

You can use ```service --status-all |grep lsyncd``` to check the service.

## Automatic start Lsyncd when power is on

##### Write a bash script to start Lsyncd

For example: ```vim /home/judge/startLsyncd.sh```

```
#! /bin/bash

lsyncd -log Exec /etc/lsyncd/lsyncd.conf.lua
service lsyncd start
```

##### Create rc-local.service and edit it

```sudo vim /etc/systemd/system/rc-local.service```

##### Add the following to the file

```
[Unit]
Description=/etc/rc.local Compatibility
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
```

##### Add the bash script to rc.local

```vim /etc/rc.local```

```
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

sudo /home/judge/startLsyncd.sh
```

##### Give permission to rc.local

```sudo chmod +x /etc/rc.local```

##### Start service and check the status

```
sudo systemctl enable rc-local
sudo systemctl start rc-local.service
sudo systemctl status rc-local.service
```

##### reboot

```reboot``` the ubuntu and check whether Lsyncd is turned on successfully.
