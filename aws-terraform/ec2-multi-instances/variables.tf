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
  description = "Region for ec2.It is same with vpc region.."
  default = "ap-northeast-1"   
}
#database server sections
variable "instance_amis" {
  type = list
  description = "Desired amis for each server on list."
  default = ["ami-0df99b3a8349462c6","ami-0bccc42bba4dedac1","ami-0bccc42bba4dedac1"]
} 

variable "instance_types" {
  type = list
  description = "Desired instance type(eg-t3.micro) for each server on list."
  default = ["t2.small","t2.micro","t2.micro"]
}

variable "subnet_ids" {
    type = list
    description = "Assign correct subnet ids to lay for each server."
    default = ["subnet-03762aa46530ad883","subnet-06d87366eb5a55490","subnet-058056221f7752f16"]
}

variable "privates_ips" {
  type = list
  description = "Assign desired private ip for each server that corresponds to subnet id."
  default = ["10.200.0.20","10.200.3.20","10.200.4.20"]
}

variable "server_tag_name" {
  type = string 
  description = "Assign server name post-fix for each associated server."
  default = "database"
}
variable "key_pair" {
  type = string
  description = "Key par name that associated with instances.((keypar.pem) should be keypar only.)"
  default = "sysadmintokyo"
}

