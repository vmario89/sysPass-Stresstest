# sysPass-Stresstest

Just some benchmark to find out how much passwords can be encrypted in a given amount of time and parallel requests. This script is just a quick win thing and was written in ~30 minutes. It may get improved.

## How to install
```
cd /opt
git clone https://leyghis.fablabchemnitz.de:8444/MarioVoigt/sysPass-Stresstest.git
cd /opt/sysPass-Stresstest
chmod +x /opt/sysPass-Stresstest/*.sh
```

## How to configure
Edit syspass-stresstest.sh head parameters to match your instance. You need to create at least one API user token which has access to view passwords (method "account/viewPass").

```
vim /opt/sysPass-Stresstest/syspass-stresstest.sh

TOKENPASS
AUTHTOKEN
TARGET_URL
```

## How to run
You should run this script on another server than the server which is running sysPass Web Server or Database itself

```
#Adjust the parameters as you like
/opt/sysPass-Stresstest/syspass-stresstest-execute.sh --duration=10 --sessions=20
```

Example Output:
```
23:35:39 ✔ root@seafile-oracle-vm:/opt# ./syspass-stresstest-execute.sh --duration=10 --sessions=20
Killing old process if running ...
syspass-stresstest.sh: no process found
Removing old files ...
rm: cannot remove 'syspass-stresstest-run-*.log': No such file or directory
Starting stress test for 10 seconds ...
05.10.2018 - 23:35:42
Please visit the frontend website and test if it still reacts smooth
Stopping stress test ...
05.10.2018 - 23:35:52
62 passwords in 10 seconds
```

## Hints
When starting the script you should monitor 
* your Web Server / Database Server to check the load
* your sysPass frontend how it responds - if it still does not slow down raise the amount of parallel sessions. Maybe also run the script from different servers / clients