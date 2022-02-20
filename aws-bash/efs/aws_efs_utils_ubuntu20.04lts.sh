#!/bin/bash

#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)

#https://github.com/wintun-devop(My github repo)

#Necessary Update for system packages
apt update -y

#Installing dependencies for amazon-efs-utils for ubuntu
apt install -y git-all binutils make nfs-common curl gcc make net-tools network-manager

#Change directory for third-party software installation
cd /opt/

#Cloning the aws-efs-utils git repo
git clone https://github.com/aws/efs-utils

#change directory to build necessary packages
cd efs-utils

#Build the amazon-efs-utils package by using default script(build-deb.sh exist already on efs-utils folder)
./build-deb.sh

#Installing aws-efs-utils 
apt install -y ./build/amazon-efs-utils*deb