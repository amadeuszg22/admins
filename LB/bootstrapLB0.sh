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
sudo touch /etc/apache2/sites-enabled/NMC
sudo echo "
<VirtualHost *:80>
        ProxyRequests off
        
        ServerName NMC

        <Proxy balancer://NMC>
                # WebHead1
                BalancerMember http://192.168.10.11:80
                # WebHead2
                BalancerMember http://192.168.10.12:80

                # Security 'technically we aren't blocking
                # anyone but this the place to make those
                # chages
                Order Deny,Allow
                Deny from none
                Allow from all

                # Load Balancer Settings
                # We will be configuring a simple Round
                # Robin style load balancer.  This means
                # that all webheads take an equal share of
                # of the load.
                ProxySet lbmethod=byrequests

        </Proxy>

        # balancer-manager
        # This tool is built into the mod_proxy_balancer
        # module and will allow you to do some simple
        # modifications to the balanced group via a gui
        # web interface.
        <Location /balancer-manager>
                SetHandler balancer-manager

                # I recommend locking this one down to your
                # your office
                Order deny,allow
                Allow from all
        </Location>

        # Point of Balance
        # This setting will allow to explicitly name the
        # the location in the site that we want to be
        # balanced, in this example we will balance "/"
        # or everything in the site.
        ProxyPass /balancer-manager !
        ProxyPass / balancer://NMC/

</VirtualHost>
">/etc/apache2/sites-enabled/NMC
sudo service apache2 restart
echo "system install NFS"
sudo apt-get install nfs-kernel-server nfs-common portmap
sudo echo "/var/www/ (rw,sync,subtree_check)">> /etc/exports
sudo apt-get install git -y
sudo rm /var/www/*
sudo git clone https://github.com/amadeuszg22/NMC.git /var/www/
sudo chmod a+rw /var/www/*
sudo reboot
