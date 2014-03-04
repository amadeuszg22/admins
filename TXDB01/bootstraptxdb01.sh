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
sudo service apache2 restart
sudo apt-get install portmap nfs-common -y
echo "System install mysql-server"
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password dupa.123'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password dupa.123'
sudo apt-get install mysql-server -y
sudo apt-get install git -y
sudo mkdir /sysrepo                             
sudo git clone https://github.com/amadeuszg22/admins.git /sysrepo 
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y phpmyadmin
sudo ln -sv /etc/phpmyadmin/apache.conf /etc/apache2/conf.d/phpmyadmin.conf
sudo service apache2 restart
sudo reboot
