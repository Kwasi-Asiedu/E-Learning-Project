# Custom VPC
resource "aws_vpc" "dt_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = var.tags
}


# Reading availability zones from region
data "aws_availability_zones" "AZs" {}


# Public Subnets
resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.dt_vpc.id
  count                   = length(var.public_subnets)
  availability_zone       = element(data.aws_availability_zones.AZs.names, count.index)
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch_public

  tags = {
    Name = "${var.project_name}_${var.public_subnets[count.index]}"
  }
}


# Private Subnets
resource "aws_subnet" "private_subnets" {
  vpc_id                  = aws_vpc.dt_vpc.id
  count                   = length(var.private_subnets)
  availability_zone       = element(data.aws_availability_zones.AZs.names, count.index)
  cidr_block              = var.private_subnet_cidrs[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch_private

  tags = {
    Name = "${var.project_name}_${var.private_subnets[count.index]}"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "dt_igw" {
  vpc_id = aws_vpc.dt_vpc.id

  tags = {
    Name = "${var.project_name}_igw"
  }
}


# Elastic IP
resource "aws_eip" "dt_eip" {
  depends_on = [aws_internet_gateway.dt_igw]
}


# NAT Gateway
resource "aws_nat_gateway" "dt_ngw" {
  subnet_id     = aws_subnet.public_subnets[0].id
  allocation_id = aws_eip.dt_eip.id

  tags = {
    Name = "${var.project_name}_ngw"
  }
}


#Public Route table  
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.dt_vpc.id

  route {
    cidr_block = var.open_cidr
    gateway_id = aws_internet_gateway.dt_igw.id
  }

  tags = {
    Name = "${var.project_name}_public_route_table"
  }
}


# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.dt_vpc.id

  route {
    cidr_block = var.open_cidr
    gateway_id = aws_nat_gateway.dt_ngw.id
  }

  tags = {
    Name = "${var.project_name}_private_route_table"
  }
}


# First public route table association
resource "aws_route_table_association" "public_route_table_1" {
  subnet_id      = aws_subnet.public_subnets[0].id
  route_table_id = aws_route_table.public_route_table.id
}


# Second public route table association
resource "aws_route_table_association" "public_route_table_2" {
  subnet_id      = aws_subnet.public_subnets[1].id
  route_table_id = aws_route_table.public_route_table.id
}


# First private route table association
resource "aws_route_table_association" "private_route_table_1" {
  subnet_id      = aws_subnet.private_subnets[0].id
  route_table_id = aws_route_table.private_route_table.id
}


# Second private route table association
resource "aws_route_table_association" "private_route_table_2" {
  subnet_id      = aws_subnet.private_subnets[1].id
  route_table_id = aws_route_table.private_route_table.id
}