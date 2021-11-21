#!/bin/bash

#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)

#http://www.mmuak.net

#Necessary Update for system packages
dnf update -y

#Installing dependencies for amazon-efs-utils for ubuntu20.04Lts
dnf install -y git-all nfs-utils make rpm-build

#Change directory for third-party software installation
cd /opt/

#Cloning the aws-efs-utils git repo
git clone https://github.com/aws/efs-utils

#change directory to build necessary packages
cd efs-utils

#Build the amazon-efs-utils package with make 
make rpm

#Installing aws-efs-utils 
dnf -y install ./build/amazon-efs-utils*rpm