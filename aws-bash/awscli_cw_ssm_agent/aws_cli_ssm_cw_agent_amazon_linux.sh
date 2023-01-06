#!/bin/bash

#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)

#http://www.mmuak.net

#update necessary system packages
yum update -y


#installing ssm agent
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm

#installing cloud watch agent for metric
sudo yum install -y amazon-cloudwatch-agent

#installing cloud watch agent for logs
sudo yum install -y awslogs

sudo systemctl start awslogsd
