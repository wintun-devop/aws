#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#https://www.github.com/wintun-devop
#Define vpc
resource "aws_vpc" "vpc_flask_project" {
  cidr_block = "${var.vpc_cidr_block}"
  tags={
      Name="vpc-flask-project",
      Project="TrainingAndCertification"
  }
}
#define internet gateway
resource "aws_internet_gateway" "igw01" {
  vpc_id = aws_vpc.vpc_flask_project.id
  tags = {
    Name = "igw01-flask-project",
    Project="TrainingAndCertification"
  }
}
#define public route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc_flask_project.id
  tags = {
    Name = "rt-public-flask-project",
    Project="TrainingAndCertification"
  }
}
#define private route table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc_flask_project.id
  tags = {
    Name = "rt-private-flask-project",
    Project="TrainingAndCertification"
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
  vpc_id     = aws_vpc.vpc_flask_project.id
  count = length(var.public_subnets_cidr_block)
  cidr_block = var.public_subnets_cidr_block[count.index]
  availability_zone = var.az_public[count.index]
  tags = {
    Name = "sub-${count.index+1}-public",
    Project="TrainingAndCertification"
  }
}
#define private subnets for middle api
resource "aws_subnet" "private_subnets_api" {
  vpc_id     = aws_vpc.vpc_flask_project.id
  count=length(var.private_subnet_api_cidr_block)
  cidr_block = var.private_subnet_api_cidr_block[count.index]
  availability_zone = var.az_private_api[count.index]
  tags = {
    Name = "sub-${count.index+4}-api",
    Project="TrainingAndCertification"
  }
}
#define private subnets for back end database
resource "aws_subnet" "private_subnets_database" {
  vpc_id     = aws_vpc.vpc_flask_project.id
  count=length(var.private_subnet_database_cidr_block)
  cidr_block = var.private_subnet_database_cidr_block[count.index]
  availability_zone = var.az_private_database[count.index]
  tags = {
    Name = "sub-${count.index+7}-database",
    Project="TrainingAndCertification"
  }
}
#define assocaiation for public route table and subnets
resource "aws_route_table_association" "public_rt_association" {
  count=length(var.public_subnets_cidr_block)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public-rt.id
}
#define association for private route table and api subnets
resource "aws_route_table_association" "private_rt_association_api_subnet" {
  count=length(var.private_subnet_api_cidr_block)
  subnet_id      = aws_subnet.private_subnets_api[count.index].id
  route_table_id = aws_route_table.private-rt.id
}
#define association for private route table and database subnets
resource "aws_route_table_association" "private_rt_association_database_subnet" {
  count=length(var.private_subnet_database_cidr_block)
  subnet_id      = aws_subnet.private_subnets_database[count.index].id
  route_table_id = aws_route_table.private-rt.id
}
#-------------------------VPC-----------------------------------------#