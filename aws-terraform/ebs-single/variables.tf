#http://mmuak.net
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
variable "accesskey" {
    description = "API Access key with enough privileges."
}
variable "secretkey" {
    description = "API Secret key with enough privileges."
}
variable "rg" {
    type = string
    description = "Region for ec2.It is same with vpc region."
    default = "ap-northeast-1"
}
variable "ebs_az" {
  type = string
  description = "Assing your desired availability zone correctly."
  default = "ap-northeast-1a"
}
variable "ebs_size" {
  type = number 
  description = "Assign your desired ebs volume size in Ggiga Byte(Gb)"
  default = 20
}
variable "ebs_volume_type" {
  type = string
  description = "Assign your desired ebs volume type."
# (Optional) The type of EBS volume. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp2).
  default = "gp2"
}

