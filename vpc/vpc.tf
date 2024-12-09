resource "aws_vpc" "dev_vpc" {
  cidr_block       = var.vpc_cidr_block

  tags = merge(var.tags,{
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-vpc"
  })
 
  #therse are two maps merged with the merge function into one map since AWS only accept one map per resource 
}

resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = var.public_subnet1_cidr_block
  availability_zone = var.availability_zone[0]
  map_public_ip_on_launch = true

  tags = merge(var.tags,{
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public_subnet1"
  })
 
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = var.public_subnet2_cidr_block
  availability_zone = var.availability_zone[1]
  map_public_ip_on_launch = true

  tags = merge(var.tags,{
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public_subnet2"
  })
 
}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = var.private_subnet1_cidr_block
  availability_zone = var.availability_zone[0]

  tags = merge(var.tags,{
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private_subnet1"
  })
 
}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = var.private_subnet2_cidr_block
  availability_zone = var.availability_zone[1]

  tags = merge(var.tags,{
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private_subnet2"
  })
 
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = merge(var.tags,{
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-igw"
  })
}

resource "aws_route_table" "pub_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = merge(var.tags,{
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-pub-rt"
  })
}

resource "aws_route_table_association" "pub_sub1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.pub_route_table.id
}

resource "aws_route_table_association" "pub_sub2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.pub_route_table.id
}

resource "aws_eip" "nat_eip" {
 
  domain   = "vpc"

    tags = merge(var.tags,{
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-eip"
  })
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = merge(var.tags,{
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-nat-gw"
  })

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_eip.nat_eip, aws_subnet.public_subnet1]
}

resource "aws_route_table" "priv_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = merge(var.tags,{
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-rt"
  })
}

resource "aws_route_table_association" "priv_sub1_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.priv_route_table.id
}

resource "aws_route_table_association" "priv_sub2_association" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.priv_route_table.id
}
