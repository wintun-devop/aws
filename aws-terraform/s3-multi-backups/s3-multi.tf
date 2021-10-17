provider "aws" {
  region = "${var.rg}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}
resource "aws_s3_bucket" "multi_backups" {
  count ="${length(var.s3_bucket_names)}"
  bucket = "${var.s3_bucket_names[count.index]}"
  acl = "${var.s3_acl}"
  versioning {
      enabled = true
   }
  tags = {
    Name= "BizA-bucket-${count.index+1}"
    Project="BusinessA"
  }
}