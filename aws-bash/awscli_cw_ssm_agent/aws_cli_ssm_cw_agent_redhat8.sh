#!/bin/bash

#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)

#http://www.mmuak.net


#Necessary Update for system packages
sudo dnf update -y

#install necessary packages 
sudo dnf install -y curl wget unzip gcc

#Download aws cli
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

#extract the aws cli
sudo unzip awscliv2.zip

#Installing aws cli
sudo ./aws/install

#Download the aws cloudwatch agent by wget
sudo wget https://s3.amazonaws.com/amazoncloudwatch-agent/redhat/amd64/latest/amazon-cloudwatch-agent.rpm

#install the cloudwatch agent by rpm package manager
sudo rpm -U ./amazon-cloudwatch-agent.rpm

#install the ssm-agent by rpm package manager
sudo sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
