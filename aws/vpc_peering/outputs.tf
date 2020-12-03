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
