variable "accesskey" {
    description = "API Access key with enough privileges."
}
variable "secretkey" {
    description = "API Secret key with enough privileges."
}
variable "rg" {
    type = string
    description = "AWS region to create s3 backup."
    default = "us-east-1"
}
variable "s3_acl" {
    type        = string
    description = "We will set private on default."
    default     = "private"
}
variable "resource_tag" {
   type        = map
   description = "A mapping of tags to assign to the bucket."
   default     = {
      name = "biz-a-backup-1-public"
      project  = "biz-a"
     }
}