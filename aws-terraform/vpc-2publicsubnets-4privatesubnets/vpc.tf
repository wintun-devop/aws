#provider
provider "aws" {
      region     = "${var.region}"
      access_key = "${var.access_key}"
      secret_key = "${var.secret_key}"
}
#VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "vpc-tf-stack"
  }
}
#Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "gw-tf-pvc"
  }
}
#Public Route Table 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "Public-Rt"
  }
}
#Public Route
resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
#Public Subnets
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.custom_vpc.id
  count             = length(var.public_subnet_cidr_blocks)
  cidr_block        = var.public_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones_public[count.index]
  tags = {
    Name = "sub-${count.index+1}-i"
  }
}
#Private Subnets
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  count = length(var.private_subnet_cidr_blocks)
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones_private[count.index]
  tags = {
    Name = "sub-${count.index+3}-p"
  }
}
#Public Subnets Route Table Associations
resource "aws_route_table_association" "public_rt_association" {
  count             = length(var.public_subnet_cidr_blocks)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}
