#!/bin/bash
#Win Tun Hlaing(https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA/videos)
#http://www.mmuak.net or https://mmuak.blogspot.com/

# Update/Download package information from all configured sources
apt update -y

#Upgrading the downloaded packages
apt upgrade -y

#apache and necessary modules
apt install -y apache2 wget curl make unzip network-manager gcc net-tools lsb-release ca-certificates apt-transport-https gnupg software-properties-common

#get start the apache server
systemctl start apache2

#get enable the apache server to run alway on starup
systemctl enable --now apache2

#check ufw list(optional here)
ufw app list
ufw allow 'Apache'
ufw status

#php-8 modules
add-apt-repository ppa:ondrej/php -y

#Update package information from php8.0 configured sources
apt update -y 

#install php8.0 modules
apt install -y php8.0 libapache2-mod-php8.0

#Installing additional php modules
apt install php8.0-common php8.0-mysql php8.0-xml php8.0-curl php8.0-gd php8.0-imagick php8.0-cli php8.0-dev php8.0-imap php8.0-mbstring php8.0-opcache php8.0-soap php8.0-zip -y

#check the php version
php --version

#python3.9 module
add-apt-repository ppa:deadsnakes/ppa -y

#install python3.9 modules
apt install -y python3.9 python3-dev python3-pip build-essential

#restarting apache server
systemctl restart apache2

#check the status of apache server
systemctl status apache2
