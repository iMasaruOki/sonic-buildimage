#!/bin/sh
# $1: Virtual IP address
# $2: Interface
# $3: new state (MASTER/BACKUP/FAULT/STOP)

LOGFILE=/var/log/keepalived.log
sudo touch $LOGFILE
echo "Become $3 on $2" |sudo tee -a $LOGFILE

case $3 in
    MASTER)
	sudo config interface ip add $2 $1
	;;
    BACKUP)
	sudo config interface ip remove $2 $1
	;;
    *)
	;;
esac
exit 0
