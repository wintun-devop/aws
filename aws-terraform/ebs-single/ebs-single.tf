#http://mmuak.net
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#cloud provider
provider "aws" {
  region = "${var.rg}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}
#define ebs volume
resource "aws_ebs_volume" "single-ebs" {
  availability_zone = "${var.ebs_az}"
  size              = "${var.ebs_size}"
  type = "${var.ebs_volume_type}"
  encrypted = false
  tags = {
    Name = "tf-ebs-1"
    Project = "terraform-testing"
  }
}
