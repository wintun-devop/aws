#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#https://www.github.com/wintun-devop
#Define vpc
variable "accesskey" {
    description = "description"
}
variable "secretkey" {
    description = "description"
}
variable "rg" {
    type = string
    description = "Region for vpc."
    default = "ap-southeast-1"
}
#variables assign for vpc
variable "vpc_cidr_block" {
  type        = string
  description = "CIDR Block for vpc.It should be private ip ranges for rfc 1918."
  default     = "10.55.0.0/16"
}
variable "public_subnets_cidr_block" {
  type        = list
  description = "Assigns desire subnets for your public networks."
  default     = ["10.55.0.0/24","10.55.1.0/24","10.55.2.0/24"]
}
variable "az_public" {
  type        = list
  description = "Assigns desire AZ list for public subnets."
  default     = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
}
variable "private_subnet_api_cidr_block" {
  type        = list
  description = "Assigns desire subnets for api private networks."
  default     = ["10.55.3.0/24","10.55.4.0/24","10.55.5.0/24"]
}
variable "az_private_api" {
  type        = list
  description = "Assigns desire AZ list for api private subnets."
  default     = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
}
variable "private_subnet_database_cidr_block" {
  type        = list
  description = "Assigns desire subnets for database private networks."
  default     = ["10.55.6.0/24","10.55.7.0/24","10.55.8.0/24"]
}
variable "az_private_database" {
  type        = list
  description = "Assigns desire AZ list for database private subnets."
  default     = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
}







