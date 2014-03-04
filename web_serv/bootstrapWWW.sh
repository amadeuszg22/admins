#!/usr/bin/env bash
echo "System will install server features"
echo "System Upgrades repositories"
sudo apt-get update
sudo apt-get install htop -y
echo "System install apache2"
sudo apt-get install apache2 -y
echo "System install PHP5"
sudo apt-get install php5 -y
echo "system install libraries"
sudo apt-get install libapache2-mod-auth-mysql -y
sudo apt-get install php5-mysql -y
sudo apt-get install php5-memcache -y
echo "system enables modules"
sudo a2enmod mem_cache
echo "system restart apache2 service"
rm /etc/apache2/sites-enabled/000-default
sudo service apache2 restart
sudo apt-get install portmap nfs-common -y
sudo mkdir /webfiles
sudo echo "192.168.10.2:/home/ftp/ /webfiles nfs rsize=8192,wsize=8192,timeo=14,intr">>/etc/fstab
sudo apt-get install git -y
sudo mkdir /sysrepo
git clone https://github.com/amadeuszg22/admins.git /sysrepo
sudo cp -r /sysrepo/web_serv/config/apache/* /etc/apache2/sites-enabled/
sudo service apache2 restart
sudo reboot
sudo apt-get install libio-socket-ssl-perl libnet-ssleay-perl perl -y
sudo apt-get install sendemail -y
