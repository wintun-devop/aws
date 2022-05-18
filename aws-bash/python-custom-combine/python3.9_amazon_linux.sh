#/bin/bash
#This cript is only for amazon linux 2

#update system packages
sudo update -y

#installing necessary development toos
sudo yum -y groupinstall "Development Tools"


#installing necessary packages for deployment
sudo yum -y install openssl-devel bzip2-devel libffi-devel

#downloading python packages from python repo
wget https://www.python.org/ftp/python/3.9.10/Python-3.9.10.tgz

#extract python package by tar command
tar xvf Python-3.9.10.tgz

cd Python-*/

#configure to combine package
./configure --enable-optimizations

#combine and install with make
sudo make altinstall