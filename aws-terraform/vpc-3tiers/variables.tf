variable "accesskey" {
    description = "description"
}
variable "secretkey" {
    description = "description"
}
variable "rg" {
    type = string
    description = "Region for vpc."
    default = "ap-northeast-1"
}
variable "vpc_cidr_block" {
  type = string
  description = "CIDR Block for vpc.It should be private ip ranges for rfc 1918."
  default = "10.200.0.0/16"
}

variable "public_subnets_cidr_block" {
    type = list
    description = "Assigns desire subnets for your public networks."
    default = ["10.200.0.0/24","10.200.1.0/24","10.200.2.0/24"]
}

variable "az_public" {
  type        = list
  description = "Assign desire AZ list for public subnets."
  default     = ["ap-northeast-1a","ap-northeast-1c","ap-northeast-1d"]
}

variable "private_subnet_cidr_block" {
    type = list
    description = "Assigns desire subnets for your private networks."
    default = ["10.200.3.0/24","10.200.4.0/24","10.200.5.0/24","10.200.6.0/24","10.200.7.0/24","10.200.8.0/24"]
}

variable "az_private" {
    type        = list
  description = "Assign desire AZ list for private subnets."
  default     = ["ap-northeast-1a","ap-northeast-1c","ap-northeast-1d","ap-northeast-1a","ap-northeast-1c","ap-northeast-1d"]
}