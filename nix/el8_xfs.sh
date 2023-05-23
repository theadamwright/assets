#!/bin/sh

# Adam Wright 
# <theadamwright@gmail.com>
# I use these simple steps to list and mount an extra disk on an Azure VM

lsblk
mkfs.xfs -d agcount=256 /dev/sdc
mkdir /opt/edb
mount -t xfs -o allocsize=1m,noatime,nodiratime,logbsize=256k /dev/sdc /opt/pgdata 
