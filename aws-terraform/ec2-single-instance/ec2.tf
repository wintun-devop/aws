#cloud provider
provider "aws" {
  region = "${var.rg}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}

#define ec2 instance(check to ensure security group-id) before terraform apply
resource "aws_instance" "web-server" {
    ami="${var.web_ami}"
    subnet_id = "${var.subnet_id}"
    instance_type ="${var.server_type}"
    associate_public_ip_address = true
    vpc_security_group_ids=["sg-004c8d166f876491e"]
    key_name = "${var.key_pair}"
    tags={
     Name="WebServer"
    }
}
