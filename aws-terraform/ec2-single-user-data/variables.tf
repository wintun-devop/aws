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
  default = "us-east-1"   
}
variable "server_ami" {
  type = string
  description = "Assign the desired ami your instance."
  default = "ami-083654bd07b5da81d"  
}
variable "subnet_id" {
  type = string
  description = "Assign correct subnet id to lay on your instance."
  default = "subnet-05d554164d7766b97"  
}
variable "server_type" {
  type = string
  description = "Assign desired instance type(eg-t3.micro) for instance."
  default = "t2.micro" 
}
variable "key_pair" {
  type = string
  description = "Express your key-pair name without extension(eg-server-testing.pem>>server-testing)."
  default = "server-testing"
}
