####################################
## Setup iptables TEMPORARY rules
####################################

# Adding rules by port, using the identification string: HTTPSPROBE
# Add the rules only once, or it will duplicate the logs
# --log-level 4 is the level we want. It should be the linux kernel default level. I'm setting it here only to be sure it's the desired verbosity level
sudo iptables -A INPUT -p tcp --dport 443 -j LOG --log-prefix='HTTPSPROBE ' -m comment --comment "Monitoring port 443 INPUT" --log-level 4 
sudo iptables -A OUTPUT -p tcp --dport 443 -j LOG --log-prefix='HTTPSPROBE ' -m comment --comment "Monitoring port 443 OUTPUT" --log-level 4 
sudo iptables -A FORWARD -p tcp --dport 443 -j LOG --log-prefix='HTTPSPROBE ' -m comment --comment "Monitoring port 443 FORWARD" --log-level 4 


# Listing rules
sudo iptables --list-rules
# or
sudo iptables -S


### Deleting rules
### Start the command with 'sudo iptables -D INPUT ' and paste the rest of the rule after, in order to delete it
# sudo iptables -A INPUT -p tcp --dport 443 -j LOG --log-prefix='HTTPSPROBE ' -m comment --comment "Monitoring port 443 INPUT" --log-level 4 
# sudo iptables -A OUTPUT -p tcp --dport 443 -j LOG --log-prefix='HTTPSPROBE ' -m comment --comment "Monitoring port 443 OUTPUT" --log-level 4 
# sudo iptables -A FORWARD -p tcp --dport 443 -j LOG --log-prefix='HTTPSPROBE ' -m comment --comment "Monitoring port 443 FORWARD" --log-level 4 






####################################
## Reading /var/log/messages
####################################

# Getting the log, based on the identification string: 'HTTPSPROBE'
sudo grep 'HTTPSPROBE' /var/log/messages

# Getting same data, but filtering by date
sudo grep 'Aug 24' '/var/log/messages' | sudo grep "HTTPSPROBE"



####################################
## Saving a daily log from yesterday
## This process should run everyday, because /var/log/messages only stores today and yesterday logs
####################################
sudo grep  $(date -d '-1 day' '+%b') '/var/log/messages' | sudo grep  $(date -d '-1 day' '+%d') | sudo grep "HTTPSPROBE" > '$(hostname -i)--$(date -d '-1 day' +'%Y-%m-%d').log'




### LOG SAMPLE
Aug 21 13:48:18 la-nginx-01 kernel: HTTPSPROBE: IN=ens33 OUT= MAC=00:50:56:b2:29:8d:d8:b1:22:19:e6:00:08:00 SRC=10.234.36.208 DST=172.18.3.40 LEN=52 TOS=0x02 PREC=0x00 TTL=123 ID=29898 DF PROTO=TCP SPT=53671 DPT=443 WINDOW=8192 RES=0x00 CWR ECE SYN URGP=0
Aug 21 13:48:19 la-nginx-01 kernel: HTTPSPROBE: IN=ens33 OUT= MAC=00:50:56:b2:29:8d:d8:b1:22:19:e6:00:08:00 SRC=10.234.36.208 DST=172.18.3.40 LEN=52 TOS=0x00 PREC=0x00 TTL=123 ID=29899 DF PROTO=TCP SPT=53671 DPT=443 WINDOW=8192 RES=0x00 SYN URGP=0
Aug 21 13:48:19 la-nginx-01 kernel: HTTPSPROBE: IN=ens33 OUT= MAC=00:50:56:b2:29:8d:d8:b1:22:19:e6:00:08:00 SRC=10.234.36.208 DST=172.18.3.40 LEN=48 TOS=0x00 PREC=0x00 TTL=123 ID=29900 DF PROTO=TCP SPT=53671 DPT=443 WINDOW=8192 RES=0x00 SYN URGP=0
Aug 21 13:48:25 la-nginx-01 kernel: HTTPSPROBE: IN=ens33 OUT= MAC=00:50:56:b2:29:8d:d8:b1:22:19:e6:00:08:00 SRC=172.20.240.105 DST=172.18.3.40 LEN=52 TOS=0x00 PREC=0x00 TTL=123 ID=45441 DF PROTO=TCP SPT=55471 DPT=443 WINDOW=64896 RES=0x00 SYN URGP=0
Aug 21 13:48:26 la-nginx-01 kernel: HTTPSPROBE: IN=ens33 OUT= MAC=00:50:56:b2:29:8d:d8:b1:22:19:e6:00:08:00 SRC=172.20.240.105 DST=172.18.3.40 LEN=52 TOS=0x00 PREC=0x00 TTL=123 ID=45442 DF PROTO=TCP SPT=55471 DPT=443 WINDOW=64896 RES=0x00 SYN URGP=0
Aug 21 13:48:26 la-nginx-01 kernel: HTTPSPROBE: IN=ens33 OUT= MAC=00:50:56:b2:29:8d:d8:b1:22:19:e6:00:08:00 SRC=172.20.240.105 DST=172.18.3.40 LEN=52 TOS=0x00 PREC=0x00 TTL=123 ID=45443 DF PROTO=TCP SPT=55471 DPT=443 WINDOW=64896 RES=0x00 SYN URGP=0
Aug 21 13:48:27 la-nginx-01 kernel: HTTPSPROBE: IN=ens33 OUT= MAC=00:50:56:b2:29:8d:d8:b1:22:19:e6:00:08:00 SRC=172.20.240.105 DST=172.18.3.40 LEN=52 TOS=0x00 PREC=0x00 TTL=123 ID=45444 DF PROTO=TCP SPT=55471 DPT=443 WINDOW=64896 RES=0x00 SYN URGP=0
Aug 21 13:48:27 la-nginx-01 kernel: HTTPSPROBE: IN=ens33 OUT= MAC=00:50:56:b2:29:8d:d8:b1:22:19:e6:00:08:00 SRC=172.20.240.105 DST=172.18.3.40 LEN=52 TOS=0x00 PREC=0x00 TTL=123 ID=45445 DF PROTO=TCP SPT=55471 DPT=443 WINDOW=64896 RES=0x00 SYN URGP=0




# Get machine IP
hostname --ip-address


# Test local port 443
nc -zv 127.0.0.1 443


# Testing connectivity from Windows machine (power shell)
Test-NetConnection 172.18.3.40 -Port 443







########################################################################
###   ________   _________ _____             _____ 
###  |  ____\ \ / /__   __|  __ \     /\    / ____|
###  | |__   \ V /   | |  | |__) |   /  \  | (___  
###  |  __|   > <    | |  |  _  /   / /\ \  \___ \ 
###  | |____ / . \   | |  | | \ \  / ____ \ ____) |
###  |______/_/ \_\  |_|  |_|  \_\/_/    \_\_____/ 
###
########################################################################



# Get package count by rule
sudo iptables -L -nvx



### # Install lnav to filter logs
### sudo dnf install epel-release -y
### sudo dnf install lnav -y





####################################
## Changing rsyslog.conf file to save kern logs into a new file
## (Optional. If this is done, the log process changes)
####################################
sudo nano -c /etc/rsyslog.conf
# Add this line
# kern.warning                                            /var/log/iptables.log
# save and close, restart rsyslog












