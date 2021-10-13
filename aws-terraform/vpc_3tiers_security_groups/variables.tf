variable "accesskey" {
    description = "AWS API access-key for api call."
}
variable "secretkey" {
    description = "AWS API secret-key for api call."
}
variable "rg" {
    type = string
    description = "Region for vpc."
    default = "us-east-1"
}
variable "vpc_cidr_block" {
  type = string
  description = "CIDR Block for vpc.It should be private ip ranges for rfc 1918."
  default = "172.20.0.0/16"
}

variable "public_subnets_cidr_block" {
    type = list
    description = "Assigns desire subnets for your public networks."
    default = ["172.20.0.0/24","172.20.1.0/24","172.20.2.0/24"]
}

variable "az_public" {
  type        = list
  description = "Assign desire AZ list for public subnets."
  default     = ["us-east-1a","us-east-1b","us-east-1c"]
}

variable "private_subnet_cidr_block" {
    type = list
    description = "Assigns desire subnets for your private networks."
    default = ["172.20.3.0/24","172.20.4.0/24","172.20.5.0/24","172.20.6.0/24","172.20.7.0/24","172.20.8.0/24"]
}

variable "az_private" {
    type        = list
  description = "Assign desire AZ list for private subnets."
  default     = ["us-east-1a","us-east-1b","us-east-1c","us-east-1a","us-east-1b","us-east-1c"]
}