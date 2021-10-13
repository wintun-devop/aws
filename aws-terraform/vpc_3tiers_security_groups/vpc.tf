#cloud provider
provider "aws" {
  region = "${var.rg}"
  access_key = "${var.accesskey}"
  secret_key = "${var.secretkey}"
}
#define vpc
resource "aws_vpc" "vpc3tier" {
  cidr_block = var.vpc_cidr_block
  tags={
      Name="vpc-3tiers"
  }
}
#define internet gateway
resource "aws_internet_gateway" "igw01" {
  vpc_id = aws_vpc.vpc3tier.id
  tags = {
    Name = "igw01"
  }
}
#define public route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc3tier.id
  tags = {
    Name = "Rt-Public"
  }
}
#define private route table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc3tier.id
  tags = {
    Name = "Rt-Private"
  }
}
#define public route
resource "aws_route" "public-route" {
  route_table_id            = aws_route_table.public-rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw01.id
}
#define public subnets
resource "aws_subnet" "public_subnets" {
  vpc_id     = aws_vpc.vpc3tier.id
  count = length(var.public_subnets_cidr_block)
  cidr_block = var.public_subnets_cidr_block[count.index]
  availability_zone = var.az_public[count.index]
  tags = {
    Name = "sub-${count.index+1}-public"
  }
}
#define private subnets
resource "aws_subnet" "private_subnets" {
  vpc_id     = aws_vpc.vpc3tier.id
  count=length(var.private_subnet_cidr_block)
  cidr_block = var.private_subnet_cidr_block[count.index]
  availability_zone = var.az_private[count.index]
  tags = {
    Name = "sub-${count.index+4}-private"
  }
}
#define assocaiation for public route table and subnets
resource "aws_route_table_association" "public_rt_association" {
  count=length(var.public_subnets_cidr_block)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public-rt.id
}
#define association for private route table and subnets
resource "aws_route_table_association" "private_rt_association" {
  count=length(var.private_subnet_cidr_block)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private-rt.id
}
#define security group for web servers
resource "aws_security_group" "sg_webserver" {
  name        = "WebServer"
  description = "Allow necessary traffics for web server."
  vpc_id      = aws_vpc.vpc3tier.id

  ingress {
    description = "allows https traffic."
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allows http traffic."
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
   ingress {
    description = "allows remote access traffic."
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    description = "allows icmp traffic."
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg-web"
  }
}
#define security for datbase servers
resource "aws_security_group" "sg_database" {
  name        = "DatabaseServer"
  description = "Allow necessary traffics for databae tiers internally."
  vpc_id      = aws_vpc.vpc3tier.id

  ingress {
    description = "Allows mysql traffic for internal networks."
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc3tier.cidr_block]
  }
  ingress {
    description = "Allows ssh traffic for internal networks."
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc3tier.cidr_block]
  }
  ingress {
    description = "allows icmp traffic for internal networks."
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = [aws_vpc.vpc3tier.cidr_block]
  }
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg-db"
  }
}
