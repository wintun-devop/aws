#!/bin/bash

#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)

#http://www.mmuak.net

#necessary packages(unzip,wget) should be installed previously.

#Necessary Update for system packages
apt update -y

#Download aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

#extract the aws cli
unzip awscliv2.zip

#Installing aws cli
./aws/install

#Download the aws cloudwatch agent by wget
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb

#install the cloudwatch agent by dpkg
dpkg -i -E ./amazon-cloudwatch-agent.deb

