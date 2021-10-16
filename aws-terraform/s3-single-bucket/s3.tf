provider "aws" {
  region = "${var.rg}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}
resource "aws_s3_bucket" "s3_backup" {
  #Assign desire bucket name here
  bucket = "bucketbizapublic02"
  acl = "${var.s3_acl}"
  versioning {
      enabled = true
   }
  tags = "${var.resource_tag}"
}


