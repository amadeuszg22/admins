#!/usr/bin/env bash
echo "System will install server features"
echo "System Upgrades repositories"
echo "system install NFS"
sudo apt-get update
sudo apt-get install nfs-kernel-server nfs-common portmap -y
sudo echo "/ftp/ftp/ (rw,sync,subtree_check)">> /etc/exports
echo "Git installation"
sudo apt-get install git -y
sudo mkdir /sysrepo
git clone https://github.com/amadeuszg22/admins.git /sysrepo
echo "FTP server installation"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y proftpd
sudo cp -r /sysrepo/nfs/config/proftpd.conf /etc/proftpd/
sudo useradd -d /home/ftp -m ftpusr -p 123  -s /bin/false
sudo reboot

