#!/bin/sh
# $1: Virtual IP address
# $2: Interface
# $3: new state (MASTER/BACKUP/FAULT/STOP)
# $4: downlink inteface #0
# $5: downlink inteface #1

LOGFILE=/var/log/keepalived.log
sudo touch $LOGFILE
echo "Become $3 on $2 (VIP $1, downlink $4, $5)" |sudo tee -a $LOGFILE

case $3 in
    MASTER)
	sudo config interface ip add $2 $1
        test "x$4" != "x" && sudo config interface startup $4
        test "x$5" != "x" && sudo config interface startup $5
	;;
    BACKUP)
	sudo config interface ip remove $2 $1
        test "x$4" != "x" && sudo config interface shutdown $4
        test "x$5" != "x" && sudo config interface shutdown $5
	;;
    *)
	;;
esac
exit 0
