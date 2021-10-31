#http://mmuak.net
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#cloud provider
provider "aws" {
  region = "${var.rg}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}
#define multiples ebs volumes
resource "aws_ebs_volume" "ebs-multi" {
  count = length(var.ebs_azs)
  availability_zone = "${var.ebs_azs[count.index]}"
  size              = "${var.ebs_volume_sizes[count.index]}"
  type = "${var.ebs_volule_types[count.index]}"
  encrypted = false
  tags = {
    Name = "ebs-${count.index+1}-${var.ebs_name_suffic[count.index]}"
    Project = "tf-testing"
  }
}
