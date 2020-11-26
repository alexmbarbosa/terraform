output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.ec2_instance.id
}

output "public_ip" {
  description = "EC2 Public IP"
  value       = aws_instance.ec2_instance.public_ip
}

output "private_ip" {
  description = "EC2 Private IP"
  value       = aws_instance.ec2_instance.private_ip
}

output "root_block_device" {
  description = "EBS Block Storage ID"
  value       = aws_instance.ec2_instance.root_block_device
}