# sysPass-Stresstest

Just some benchmark to find out how much passwords can be encrypted in a given amount of time and parallel requests. It's just a little script around the util "Apache Bench" which is called by "ab" command.

## How to install
```
cd /opt
git clone https://github.com/vmario89/sysPass-Stresstest.git
cd /opt/sysPass-Stresstest/ab-benchmark
chmod +x /opt/sysPass-Stresstest/ab-benchmark/*.sh

apt-get install apache-utils
```

## How to configure
Edit syspass-stresstest.sh parameters to match your instance. You need to create at least one API user token which has access to view passwords (method "account/viewPass").

```
vim /opt/sysPass-Stresstest/ab-benchmark/syspass-stresstest.sh

TOKENPASS
AUTHTOKEN
TARGET_URL
```

## How to run
You should run this script on another server than the server which is running sysPass Web Server or Database itself

```
#Adjust the parameters as you like
/opt/sysPass-Stresstest/ab-benchmark/syspass-stresstest.sh
```

Example Output:
```
20:25:22 ✔ root@git-droid:/opt/sysPass-Stresstest/ab-benchmark# ./syspass-stresstest.sh
35 passwords
400 requests
400 concurrency
5 timeout
60 timelimit
8.75% of requested passwords decryptions could be retrieved in given timeout range. To get better values raise timeout limit, reduce concurrency or pimp your server settings.
```

## Hints
When starting the script you should monitor 
* your Web Server / Database Server to check the load
* your sysPass frontend how it responds - if it still does not slow down raise the amount of parallel sessions. Maybe also run the script from different servers / clients
