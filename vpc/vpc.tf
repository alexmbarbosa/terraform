# Resource: VPC #-----------------------------------
resource "aws_vpc" "SysOpsVPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  enable_dns_support = true

  tags = {
    Name = "SysOpsVPC"
  }
}

# Resource: Internet Gateway #-----------------------
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.SysOpsVPC.id
  tags = {
    Name = "IGW"
  }
}

# Resource: Public Subnets #-------------------------
resource "aws_subnet" "DMZ1public" {
  vpc_id     = aws_vpc.SysOpsVPC.id
  cidr_block = var.DMZ1public
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "DMZ1public"
  }
}

resource "aws_subnet" "DMZ2public" {
  vpc_id     = aws_vpc.SysOpsVPC.id
  cidr_block = var.DMZ2public
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "DMZ2public"
  }
}

# Resource: Private APP Subnets #----------------------
resource "aws_subnet" "AppLayer1private" {
  vpc_id     = aws_vpc.SysOpsVPC.id
  cidr_block = var.AppLayer1private
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "AppLayer1private"
  }
}

resource "aws_subnet" "AppLayer2private" {
  vpc_id     = aws_vpc.SysOpsVPC.id
  cidr_block = var.AppLayer2private
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "AppLayer2private"
  }
}

# Resource: Private DB Subnets #-----------------------
resource "aws_subnet" "DBLayer1private" {
  vpc_id     = aws_vpc.SysOpsVPC.id
  cidr_block = var.DBLayer1private
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "DBLayer1private"
  }
}

resource "aws_subnet" "DBLayer2private" {
  vpc_id     = aws_vpc.SysOpsVPC.id
  cidr_block = var.DBLayer2private
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "DBLayer2private"
  }
}


#-- NAT GATEWAY OPT -----------------------------------------
resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "NGW" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.DMZ2public.id

  tags = {
    Name = "NGW"
  }
}
#-- NAT GATEWAY OPT -----------------------------------------


# Resource: Public Route Table #-----------------------
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.SysOpsVPC.id
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
  vpc_id = aws_vpc.SysOpsVPC.id
  tags = {
    Name = "PrivateRT"
  }
}

# Subnets Associations: Publics #-----------------------
resource "aws_route_table_association" "PublicRTA" {
  subnet_id      = aws_subnet.DMZ1public.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_route_table_association" "PublicRTB" {
  subnet_id      = aws_subnet.DMZ2public.id
  route_table_id = aws_route_table.PublicRT.id
}

# Subnets Associations: Private APP #-------------------
resource "aws_route_table_association" "PrivateRTA1" {
  subnet_id      = aws_subnet.AppLayer1private.id
  route_table_id = aws_route_table.PrivateRT.id
}

resource "aws_route_table_association" "PrivateRTB1" {
  subnet_id      = aws_subnet.AppLayer2private.id
  route_table_id = aws_route_table.PrivateRT.id
}

# Subnets Associations: Private DB #--------------------
resource "aws_route_table_association" "PrivateRTA2" {
  subnet_id      = aws_subnet.DBLayer1private.id
  route_table_id = aws_route_table.PrivateRT.id
}

# Subnets Associations: Private DB #--------------------
resource "aws_route_table_association" "PrivateRTB2" {
  subnet_id      = aws_subnet.DBLayer2private.id
  route_table_id = aws_route_table.PrivateRT.id
}
