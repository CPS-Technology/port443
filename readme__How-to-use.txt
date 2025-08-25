----------------------------------------------------------
Setup to use iptables in order to monitor port 443
----------------------------------------------------------

#########################################
# First setup - Create folder and copy files
#########################################


### Create a directory for the scripts: /etc/port443
sudo mkdir -p /etc/port443 
sudo cd /etc/port443

### Copy all script files into this folder


# Make all script executable
sudo chmod +x /etc/port443/*.sh



#########################################
# Add scripts to CRONTAB
#########################################

### How to add 443 port jobs to cron tab

# Edit crontab
$ crontab -e


# Add the following lines
@reboot   /etc/port443/port443_01_updateiptables.sh
5 * * * * /etc/port443/port443_01_updateiptables.sh
7 0 * * * /etc/port443/port443_02_extractlog.sh
10 0 * * * /etc/port443/port443_03_movelog.sh

# If using VIM to edit crontab, press :x! to close and save


# List crontab:
crontab -l


# Run ALL scripts at least once, just to be sure everything is working fine
sudo sh /etc/port443/port443_01_updateiptables.sh
sudo sh /etc/port443/port443_02_extractlog.sh
sudo sh /etc/port443/port443_03_movelog.sh



### SETUP IS DONE HERE



### Cron job sctructure: 
### 
###   minute hour day-of-month month day-of-week command
###
###   * * * * * "command to be executed"
###   - - - - -
###   | | | | |
###   | | | | ----- Day of week (0 - 7) (Sunday=0 or 7)
###   | | | ------- Month (1 - 12)
###   | | --------- Day of month (1 - 31)
###   | ----------- Hour (0 - 23)
###   ------------- Minute (0 - 59)
###
### run a command every Monday at 5:30 in the afternoon:
### 30 17 * * 1 /path/to/command
###
### or every 15 minutes
### */15 * * * * /path/to/command




#########################################
# Crontab jobs description
#########################################


# port443_01_updateiptables.sh
    - Script use: Update the iptables rules, allowing saving port 443 traffic 
    - Runs after reboot 
    - Runs every hour, at minute 5


# port443_02_extractlog.sh
	- Script use: The output is a new file, with the daily logs, like this: '/var/log/port443/172.18.3.40--2025-08-24.log'
	  - Filename structure: {SERVER_IP}--{YYYY-MM-DD}.log
    - Runs every day, at 00:07, in order to generate a log file with all messages/log from the day before
	- This process can run any time, as long as it runs every day


# TBD --> port443_03_movelog.sh
    - Script use: copy "yesterday" file to some consolidation area. 
    - Runs every day, at 00:10 (only AFTER extract log script)
      - Be sure addresses and credentials are correct
      - Test if it works before add into crontab, or else the files won't be copied to the consolidation area   


