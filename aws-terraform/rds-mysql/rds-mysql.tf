#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#https://github.com/wintun-devop
provider "aws" {
  region = "${var.rg}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}
#Define security group for mysql instance
resource "aws_security_group" "rds_mysql8_sg" {
  name        = "${var.rds_sg_name}"
  vpc_id      = "${var.vpc_id}"
  ingress {
    description = "Allow mysql port for internal traffic only."
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = []
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysql-rds-sg",
    Project="TrainingAndCertification"
  }
}
#Define database subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.rd_subnet_group_name}"
  subnet_ids =  "${var.subnet_group_ids}"        
  tags = {
    Name = "db-subnets",
    Project="TrainingAndCertification"
  }
}
#Define RDS Mysql8 Instance
resource "aws_db_instance" "mysql8" {
  engine                = "${var.db_type}"
  engine_version        = "${var.db_version}"
  instance_class        = "${var.db_instance_type}"
  identifier            = "${var.db_identifier}"
  allocated_storage     = "${var.storage_capacity}"
  db_name               = "${var.db_name}"
  username              = "${var.db_username}"
  password              = "${var.db_password}"
  multi_az              = "${var.multi_az_option}"
  publicly_accessible   = false
  deletion_protection   = false
  skip_final_snapshot   = true
  db_subnet_group_name  = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids=[aws_security_group.rds_mysql8_sg.id]
  tags = {
    Name = "rds-mysql8",
    Project="TrainingAndCertification"
  }
}