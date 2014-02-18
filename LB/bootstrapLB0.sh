#!/usr/bin/env bash

echo "System will install server features"


echo "System Upgrades repositories"
sudo apt-get update
echo "System install apache2"
sudo apt-get install apache2 -y
sudo echo "127.0.0.1 LB0"> /etc/hosts
echo "System install PHP5"
sudo apt-get install php5 -y
echo "system install libraries"
sudo apt-get install libapache2-mod-auth-mysql -y
sudo apt-get install php5-mysql -y
sudo apt-get install php5-memcache -y
echo "system enables modules"
sudo a2enmod proxy_balancer
sudo a2enmod proxy_http
sudo a2enmod mem_cache
echo "system restart apache2 service"
echo "LB0" > /etc/hostname
sudo rm /etc/apache2/sites-enabled/000-default
sudo apt-get install git -y
sudo mkdir /sysrepo
git clone https://github.com/amadeuszg22/admins.git /sysrepo
cp -r LB/config/* /etc/apache2/sites-enabled/
sudo service apache2 restart
echo "system install NFS"
sudo apt-get install nfs-kernel-server nfs-common portmap
sudo echo "/home/ftp/ (rw,sync,subtree_check)">> /etc/exports
sudo rm /var/www/*
sudo reboot
