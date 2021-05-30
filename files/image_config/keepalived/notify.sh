#!/bin/sh
# $1: Virtual IP address
# $2: Interface
# $3: new state (MASTER/BACKUP/FAULT/STOP)

touch /var/log/keepalive.log
echo "Become $3 on $2" >> /var/log/keepalived.log
