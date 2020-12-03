# Resource: VPC #-----------------------------------
resource "aws_vpc" "ZooxDataDEV" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "ZooxDataDEV"
  }
}

# Resource: Public Subnets #-------------------------
resource "aws_subnet" "pubDEV1" {
  vpc_id                  = aws_vpc.ZooxDataDEV.id
  cidr_block              = var.pubDEV1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pubDEV1"
  }
}

resource "aws_subnet" "pubDEV2" {
  vpc_id                  = aws_vpc.ZooxDataDEV.id
  cidr_block              = var.pubDEV2
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pubDEV2"
  }
}

# Resource: Private APP Subnets #----------------------
resource "aws_subnet" "prvDEV1" {
  vpc_id                  = aws_vpc.ZooxDataDEV.id
  cidr_block              = var.prvDEV1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "prvDEV1"
  }
}

resource "aws_subnet" "prvDEV2" {
  vpc_id                  = aws_vpc.ZooxDataDEV.id
  cidr_block              = var.prvDEV2
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "prvDEV2"
  }
}

# Resource: Internet Gateway #-----------------------
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.ZooxDataDEV.id

  tags = {
    Name = "IGW"
  }
}

# Resource: Public Route Table #-----------------------
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.ZooxDataDEV.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "PublicRT"
  }
}

#Overwrite default route table of VPC(Master) with our route table entries
resource "aws_main_route_table_association" "PublicRT" {
  vpc_id         = aws_vpc.ZooxDataDEV.id
  route_table_id = aws_route_table.PublicRT.id
}

# Resource: Private Route Table #-----------------------
resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.ZooxDataDEV.id

  tags = {
    Name = "PrivateRT"
  }
}


# Subnets Associations: Public DMZ #--------------------
resource "aws_route_table_association" "PublicRTA" {
  subnet_id      = aws_subnet.pubDEV1.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_route_table_association" "PublicRTB" {
  subnet_id      = aws_subnet.pubDEV2.id
  route_table_id = aws_route_table.PublicRT.id
}

# Subnets Associations: Private APP #-------------------
resource "aws_route_table_association" "PrivateRTA1" {
  subnet_id      = aws_subnet.prvDEV1.id
  route_table_id = aws_route_table.PrivateRT.id
}

resource "aws_route_table_association" "PrivateRTB1" {
  subnet_id      = aws_subnet.prvDEV2.id
  route_table_id = aws_route_table.PrivateRT.id
}

