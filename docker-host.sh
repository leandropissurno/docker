#!/bin/bash
echo "vagrant:vagrant"|chpasswd
systemctl stop firewalld;systemctl disable firewalld
timedatectl set-timezone America/Sao_Paulo
echo net.ipv6.conf.default.disable_ipv6 = 1 >> /etc/sysctl.conf
echo net.ipv6.conf.all.disable_ipv6 = 1 >> /etc/sysctl.conf
sysctl -p
subscription-manager repos --enable=rhel-7-server-extras-rpms
yum -y install vim docker nmap bash-completion mlocate net-tools traceroute
yum -y update