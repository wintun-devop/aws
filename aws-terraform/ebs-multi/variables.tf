#http://mmuak.net
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
variable "accesskey" {
    type = string
    description = "API Access key with enough privileges."
}
variable "secretkey" {
    type = string
    description = "API Secret key with enough privileges."
}
variable "rg" {
    type = string
    description = "Region for ebs volues.It is same with vpc and ec-2 region."
    default = "us-east-1"
}
variable "ebs_azs" {
  type = list(string)
  description = "Assing your desired associated availability zone for each ebs correctly."
  default = [ "us-east-1a","us-east-1c","us-east-1d" ]
}
variable "ebs_volume_sizes" {
  type = list(number)
  description = "Assing your desired ebs volume size for each ebs correctly."
  default = [ 10,20,20 ]
}
variable "ebs_volule_types" {
  type = list(string)
  #(Optional) The type of EBS volume. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp2).
  description = "Assign your desired ebs volume type for each ebs correctly."
  default = [ "gp2","gp3","standard" ]
}
variable "ebs_name_suffic" {
  type = list(string)
  description = "(Optional) ebs name suffic according to your project."
  default = ["web-data","db-backup","db-archive"]
}

