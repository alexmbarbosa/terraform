output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.ZooxDataDEV.id
}

output "pubDEV1" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.pubDEV1.id
}

output "pubDEV2" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.pubDEV2.id
}

output "prvDEV1" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.prvDEV1.id
}

output "prvDEV2" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.prvDEV2.id
}

output "connection_id" {
  value       = aws_vpc_peering_connection.dev-to-prd.id
  description = "VPC peering connection ID"
}

output "accept_status" {
  value       = aws_vpc_peering_connection.dev-to-prd.accept_status
  description = "The status of the VPC peering connection request"
}
