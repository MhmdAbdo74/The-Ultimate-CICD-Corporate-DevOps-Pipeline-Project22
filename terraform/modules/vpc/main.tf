# create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true
  enable_dns_support =  true

  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}
# create internet_gateway and attach to vpc
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}
#to bring avaliable AZS
data "aws_availability_zones" "available" {}
#create public subnets 
resource "aws_subnet" "pub_sub_1a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_sub_1a_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-pub-sub-1a"
  }
}

resource "aws_subnet" "pub_sub_2b" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_sub_2b_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-pub-sub-2b"
  }
}

# create route table
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.project_name}-pub-rt"
  }
}
# associate public subnet to route table 
resource "aws_route_table_association" "pub_sub_1a_rt_association" {
  subnet_id      = aws_subnet.pub_sub_1a.id
  route_table_id = aws_route_table.pub_rt.id
}
resource "aws_route_table_association" "pub_sub_2b_rt_association" {
  subnet_id      = aws_subnet.pub_sub_2b.id
  route_table_id = aws_route_table.pub_rt.id
}

