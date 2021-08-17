variable "access_key" {
  description = "description"
}
variable "secret_key" {
  description = "description"
}
variable "region" {
  type        = string
  description = "Region for vpc."
  default     = "us-east-1"
}
variable "cidr_block" {
  type        = string
  description = "CIDR address block for vpc."
  default     = "10.50.0.0/16"
}
variable "public_subnet_cidr_blocks" {
  type        = list
  description = "Addresses list for public subnets."
  default     = ["10.50.0.0/24","10.50.1.0/24"]
}
variable "availability_zones_public" {
  type        = list
  description = "AZ list for public subnets."
  default     = ["us-east-1a","us-east-1b"]
}
variable "private_subnet_cidr_blocks" {
  type        = list
  description = "Addresses list for private subnets."
  default     = ["10.50.2.0/24", "10.50.3.0/24", "10.50.4.0/24", "10.50.5.0/24"]
}
variable "availability_zones_private" {
  type        = list
  description = "AZ list for private subnets"
  default     = ["us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}






