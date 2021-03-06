#!/bin/bash

#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)

#https://github.com/wintun-devop(My github repo)

#Necessary Update for system packages
dnf update -y

#Installing dependencies for amazon-efs-utils for Redhat8
dnf install -y git-all nfs-utils make rpm-build net-tools

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