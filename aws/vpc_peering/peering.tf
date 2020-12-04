resource "aws_vpc_peering_connection" "dev-to-prd" {
  peer_vpc_id = aws_vpc.ZooxDataDEV.id
  vpc_id      = var.vpc_peer_prd
  auto_accept               = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "dev-to-prd"
  }
}

#Accept VPC peering request in prd from dev (prd <-- dev)
resource "aws_vpc_peering_connection_accepter" "accept_peering" {
  vpc_peering_connection_id = aws_vpc_peering_connection.dev-to-prd.id
  auto_accept               = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "dev-to-prd"
  }
}

# Add Routes dev x prd PCX
resource "aws_route" "pcx_dev_RT" {
  route_table_id            = aws_route_table.PublicRT.id
  destination_cidr_block    = "172.31.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.dev-to-prd.id
}

# Add Routes prd x dev PCX
resource "aws_route" "pcx_prd_RT" {
  route_table_id            = var.MainRT
  destination_cidr_block    = "10.192.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.dev-to-prd.id
}
