#http://mmuak.net
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
provider "aws" {
  region = "${var.rg}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}

resource "aws_instance" "database-multi-servers" {
  count = "${length(var.instance_amis)}"
  ami  = "${var.instance_amis[count.index]}"
  instance_type = "${var.instance_types[count.index]}"
  subnet_id = "${var.subnet_ids[count.index]}"
  associate_public_ip_address = false
  private_ip = "${var.privates_ips[count.index]}"
  vpc_security_group_ids = ["sg-004c8d166f876491e"]
  source_dest_check = true
  key_name = "${var.key_pair}"
  tags = {
    Name = "server-${count.index+1}-${var.server_tag_name}"
    Project ="biz-a"
  }
}


