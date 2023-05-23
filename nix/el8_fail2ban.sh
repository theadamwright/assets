#!/bin/sh

# Adam Wright 
# <theadamwright@gmail.com>
# This shell script installs and starts fail2ban on EL8 distribtions


echo "*********************************************************************"
echo " Installing EPEL Repo... " 
echo "*********************************************************************"
sudo dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

echo "*********************************************************************"
echo " Installing fail2ban package..."
echo "*********************************************************************"
sudo dnf -y install fail2ban

echo "*********************************************************************"
echo " Enable the fail2ban service... " 
echo "*********************************************************************"
sudo systemctl enable fail2ban

echo "*********************************************************************"
echo " Create local jail file... " 
echo "*********************************************************************"
sudo cat <<EOF >> /etc/fail2ban/jail.d/sshd.local
[sshd]
enabled = true
port = ssh
action = iptables-multiport
logpath = /var/log/secure
maxretry = 3
bantime = 14400
EOF

echo "*********************************************************************"
echo " Restart fail2ban... " 
echo "*********************************************************************"
sudo systemctl restart fail2ban

# Sleep for 5 seconds
sleep 5

echo "*********************************************************************"
echo "Check service status... " 
echo "*********************************************************************"
sudo fail2ban-client status

echo "*********************************************************************"
echo "Check sshd jail... " 
echo "*********************************************************************"
sudo fail2ban-client status sshd
