#check to ensure aws region,ami,instance-type,subnet-id and key-pair name.
variable "accesskey" {
    description = "description"
}
variable "secretkey" {
    description = "description"
}
variable "rg" {
    type = string
    description = "Region for ec2.It is same with vpc region."
    default = "ap-northeast-1"
}

variable "web_ami" {
  type = string 
  description = "Desire ami for web server.I use redhat8 ami here."
  default = "ami-0bccc42bba4dedqc1"
}
variable "server_type" {
  type = string 
  description = "Desire instance type for web server."
  default = "t2.micro"
}

variable "subnet_id" {
  type = string 
  description = "Subnet id that lays instanct on."
  default = "subnet-03762aa46530bt883"
}
variable "key_pair" {
  type = string 
  description = "please Key par name that match with instance region and no need keypairs extension."
  default = "mykeypair"
}
