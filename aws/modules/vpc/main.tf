# Resource: VPC #-----------------------------------
resource "aws_vpc" "opsVpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "opsVpc"
  }
}

# Resource: Public Subnets #-------------------------
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.opsVpc.id
  cidr_block = var.public1
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.opsVpc.id
  cidr_block = var.public2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public2"
  }
}

# Resource: Private App Subnets #----------------------
resource "aws_subnet" "privateApp1" {
  vpc_id     = aws_vpc.opsVpc.id
  cidr_block = var.privateApp1
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "privateApp1"
  }
}

resource "aws_subnet" "privateApp2" {
  vpc_id     = aws_vpc.opsVpc.id
  cidr_block = var.privateApp2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "privateApp2"
  }
}

# Resource: Private DB Subnets #-----------------------
resource "aws_subnet" "privateDB1" {
  vpc_id     = aws_vpc.opsVpc.id
  cidr_block = var.privateDB1
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "privateDB1"
  }
}

resource "aws_subnet" "privateDB2" {
  vpc_id     = aws_vpc.opsVpc.id
  cidr_block = var.privateDB2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "privateDB2"
  }
}

# Resource: Internet Gateway #-----------------------
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.opsVpc.id

  tags = {
    Name = "IGW"
  }
}

# Resource: Public Route Table #-----------------------
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.opsVpc.id
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "PublicRT"
  }
}

# Resource: Private Route Table #-----------------------
resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.opsVpc.id

  tags = {
    Name = "PrivateRT"
  }
}

# Resource: Private Route Table for RDS #---------------
resource "aws_route_table" "PrivateRTDB" {
  vpc_id = aws_vpc.opsVpc.id
  tags = {
    Name = "PrivateRTDB"
  }
}

# Subnets Associations: Public DMZ #--------------------
resource "aws_route_table_association" "PublicRTA" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_route_table_association" "PublicRTB" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.PublicRT.id
}

# Subnets Associations: Private APP #-------------------
resource "aws_route_table_association" "PrivateRTA1" {
  subnet_id      = aws_subnet.privateApp1.id
  route_table_id = aws_route_table.PrivateRT.id
}

resource "aws_route_table_association" "PrivateRTB1" {
  subnet_id      = aws_subnet.privateApp2.id
  route_table_id = aws_route_table.PrivateRT.id
}

# Subnets Associations: Private DB #--------------------
resource "aws_route_table_association" "PrivateRTDB1" {
  subnet_id      = aws_subnet.privateDB1.id
  route_table_id = aws_route_table.PrivateRTDB.id
}

# Subnets Associations: Private DB #--------------------
resource "aws_route_table_association" "PrivateRTDB2" {
  subnet_id      = aws_subnet.privateDB2.id
  route_table_id = aws_route_table.PrivateRTDB.id
}
