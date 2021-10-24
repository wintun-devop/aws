#http://mmuak.net
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#cloud provider
provider "aws" {
  region = "${var.rg}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}
#define instances on existing vpc
resource "aws_instance" "multi_servers" {
  count = length("${var.instance_amis}")
  ami           = "${var.instance_amis[count.index]}"
  instance_type = "${var.instance_types[count.index]}"
  subnet_id = "${var.subnet_ids[count.index]}"
  private_ip = "${var.privates_ips[count.index]}"
  associate_public_ip_address = "${var.public_ip_options[count.index]}"
  vpc_security_group_ids = ["${var.sg_ids[count.index]}"]
  key_name = "${var.key_pair}"
  tags = {
    Name = "server-${count.index+1}-${var.postfix[count.index]}"
    Project = "tf-testing"
  }
}


