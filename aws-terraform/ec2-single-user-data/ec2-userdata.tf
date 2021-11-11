#http://mmuak.net
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#cloud provider
provider "aws" {
  region = "${var.rg}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}
#Define EC2 instance with user data for apache,php8.0 and python3.9 for front end modules
resource "aws_instance" "web-php-fontend" {
    ami="${var.server_ami}"
    subnet_id = "${var.subnet_id}"
    instance_type ="${var.server_type}"
    associate_public_ip_address = true
    vpc_security_group_ids=["sg-008960cef0eac7978"]
    key_name = "${var.key_pair}"
    user_data = "${file("apache_php8.0_ubuntu20.04lts.sh")}"
    tags = {
     Name="php-fn2"
    }
} 
