variable "accesskey" {
    description = "API Access key with enough privileges."
}
variable "secretkey" {
    description = "API Secret key with enough privileges."
}
variable "rg" {
    type = string
    description = "AWS region to create s3 backups."
    default = "us-east-1"
}

variable "s3_bucket_names" {
  type = list
  description = "Assigns desire bucket names."
  default=["bkbizatest01","bkbizatest02","bkbizatest03"]
} 
variable "s3_acl" {
  type        = string
  description = "We will set private on default."
  default     = "private"
}