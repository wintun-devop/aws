#!/bin/bash

#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)

#https://github.com/wintun-devop

#necessary packages(unzip,wget) should be installed previously.

#Necessary Update for system packages
apt update -y

#Download aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

#extract the aws cli
unzip awscliv2.zip

#Installing aws cli
./aws/install

#installing snap package manager
sudo apt-get install snapd

#install ssm-agent with snap packages
sudo snap install amazon-ssm-agent --classic

#Download the aws cloudwatch agent by wget
curl -o amazon-cloudwatch-agent.deb https://s3.amazonaws.com/amazoncloudwatch-agent/debian/amd64/latest/amazon-cloudwatch-agent.deb

#install the cloudwatch agent by dpkg
dpkg -i -E /root/amazon-cloudwatch-agent.deb

#enable agent for startup register
systemctl enable amazon-cloudwatch-agent.service

#getting start the cloudwatch agent service
systemctl start amazon-cloudwatch-agent.service

#It is required python2 and python2-dev packages to install cloudwatch logs agent on ubuntu
curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O

#Assign desire region here
aws_region=us-east-1

#install and configure cloudwatch logs
sudo python2 ./awslogs-agent-setup.py --region ${aws_region}

