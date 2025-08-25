echo '-----------------------------'
echo 'Process started'


echo ''
echo '-----------------------------'
echo 'Setup folder'
LOG_DIR="/var/log/port443"
echo "- Working LOG directory    : "$LOG_DIR
sudo mkdir -p $LOG_DIR 
cd $LOG_DIR


echo ''
echo '-----------------------------'
LOG_SOURCE="/var/log/messages"
echo "Log Source                 : $LOG_SOURCE"
DAYS=-1
echo "Days to go back in the log : $DAYS"
echo "Selected date              : "$(date -d "$DAYS day" '+%b %d')


echo '-----------------------------'
echo 'Save log message file from yesterday'
VAR_SEARCH=$(date -d "$DAYS day" '+%b %d')
VAR_OUTPUT="$LOG_DIR/"$(hostname -i)"--"$(date -d "$DAYS day" +'%Y-%m-%d')".log"
sudo grep "$VAR_SEARCH" "$LOG_SOURCE" | sudo grep "HTTPSPROBE" > "$VAR_OUTPUT"

### sudo grep  $(date -d '-1 day' '+%b') '/var/log/messages' | sudo grep  $(date -d '-1 day' '+%d') | sudo grep "HTTPSPROBE" > $LOG_DIR'$(hostname -i)--$(date -d '-1 day' +'%Y-%m-%d').log'
echo "File: '$VAR_OUTPUT' created with success"

echo ''
echo '-----------------------------'
echo 'Process finished'
echo ''
echo ''
echo ''


