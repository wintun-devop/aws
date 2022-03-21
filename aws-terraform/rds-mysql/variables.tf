#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#https://github.com/wintun-devop
variable "accesskey" {
    description = "API Access key with enough privileges."
}
variable "secretkey" {
    description = "API Secret key with enough privileges."
}
variable "rg" {
    type = string
    description = "AWS region to create s3 backups."
    default = "ap-northeast-1"
}
#security group variables
variable "rds_sg_name" {
  type        = string
  description = "Assigns security group name for mysql rds instance."
  default     = "mysql-rds-access"
}
variable "vpc_id" {
  type        = string
  description = "Assigns associated vpc id for your database instance exist."
  default     = "vpc-034d1aca6b52ab0dc"
}
#subnet group variables
variable "rd_subnet_group_name" {
  type        = string
  description = "Assigns subnet group name for laying rds instance."
  default     = "rds-subnets"
}
variable "subnet_group_ids" {
  type        = list(string)
  description = "Assigns associated subnet group ids for laying rds instance."
  default     = ["subnet-089f67df4538bd247","subnet-0989fefc92c82c3fa","subnet-0a0a433eac87a17d9"]
}
#mysql rds instance variable
variable "db_type" {
  type        = string
  description = "Assign database engine type for your rds instance.(eg-mysql,postgres,mariadb)"
  default     = "mysql"
}
variable "db_version" {
    type = string
    description = "Assign your desired and supported datbase version."
    default = "8.0.28"
}
variable "db_instance_type" {
    type = string
    description = "Assign your desired datbase instance type.(eg-t2.micro)."
    default = "db.t2.micro"
}
variable "storage_capacity" {
    type = number
    description = "Assign your desired storage capacity for database instance.Default is 20 GigaByte."
    default = 20
}
variable "db_name" {
    type = string
    description = "Assign your desired database name."
    default = "flaskapp01"
}
variable "db_identifier" {
  type = string
  description = "Assign the db identifier."
  default = "db-rds-mysql-1"
}
variable "db_username" {
    type = string
    description = "Assign your desired database username to manage databases."
    default = "dbadmin"   
}
variable "db_password" {
    type = string
    description = "Assign your desired database password to manage databases."
    default ="ABC123ABC123"
}
variable "multi_az_option" {
    type = bool
    description="Define whether mult az or not."
    default = false
}
