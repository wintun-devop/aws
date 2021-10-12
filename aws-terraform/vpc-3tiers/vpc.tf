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