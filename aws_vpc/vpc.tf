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

# Resource: Public Subnets #-------------------------
resource "aws_subnet" "DMZpublic1" {
  vpc_id     = aws_vpc.SysOpsVPC.id
  cidr_block = var.DMZpublic1
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "DMZpublic1"
  }
}

resource "aws_subnet" "DMZpublic2" {
  vpc_id     = aws_vpc.SysOpsVPC.id
  cidr_block = var.DMZpublic2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "DMZpublic2"
  }
}

# Resource: Private APP Subnets #----------------------
resource "aws_subnet" "AppLayerPrivate1" {
  vpc_id     = aws_vpc.SysOpsVPC.id
  cidr_block = var.AppLayerPrivate1
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "AppLayerPrivate1"
  }
}

resource "aws_subnet" "AppLayerPrivate2" {
  vpc_id     = aws_vpc.SysOpsVPC.id
  cidr_block = var.AppLayerPrivate2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "AppLayerPrivate2"
  }
}

# Resource: Private DB Subnets #-----------------------
resource "aws_subnet" "DBLayerPrivate1" {
  vpc_id     = aws_vpc.SysOpsVPC.id
  cidr_block = var.DBLayerPrivate1
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "DBLayerPrivate1"
  }
}

resource "aws_subnet" "DBLayerPrivate2" {
  vpc_id     = aws_vpc.SysOpsVPC.id
  cidr_block = var.DBLayerPrivate2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "DBLayerPrivate2"
  }
}

# Resource: Internet Gateway #-----------------------
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.SysOpsVPC.id

  tags = {
    Name = "IGW"
  }
}

# Resource: NAT Gateway -----------------------------
resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "NGW" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.DMZpublic2.id

  tags = {
    Name = "NGW"
  }
}
#-- NAT Gateway (Optional) ----------------------------

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
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NGW.id
  }
  tags = {
    Name = "PrivateRT"
  }
}

# Resource: Private Route Table for RDS #---------------
resource "aws_route_table" "PrivateRTDB" {
  vpc_id = aws_vpc.SysOpsVPC.id
  tags = {
    Name = "PrivateRTDB"
  }
}

# Subnets Associations: Public DMZ #--------------------
resource "aws_route_table_association" "PublicRTA" {
  subnet_id      = aws_subnet.DMZpublic1.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_route_table_association" "PublicRTB" {
  subnet_id      = aws_subnet.DMZpublic2.id
  route_table_id = aws_route_table.PublicRT.id
}

# Subnets Associations: Private APP #-------------------
resource "aws_route_table_association" "PrivateRTA1" {
  subnet_id      = aws_subnet.AppLayerPrivate1.id
  route_table_id = aws_route_table.PrivateRT.id
}

resource "aws_route_table_association" "PrivateRTB1" {
  subnet_id      = aws_subnet.AppLayerPrivate2.id
  route_table_id = aws_route_table.PrivateRT.id
}

# Subnets Associations: Private DB #--------------------
resource "aws_route_table_association" "PrivateRTDB1" {
  subnet_id      = aws_subnet.DBLayerPrivate1.id
  route_table_id = aws_route_table.PrivateRTDB.id
}

# Subnets Associations: Private DB #--------------------
resource "aws_route_table_association" "PrivateRTDB2" {
  subnet_id      = aws_subnet.DBLayerPrivate2.id
  route_table_id = aws_route_table.PrivateRTDB.id
}
