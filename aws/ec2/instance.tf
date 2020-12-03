resource "aws_instance" "ec2_instance" {
  ami                         = var.image
  instance_type               = var.type
  key_name                    = var.keypair
  subnet_id                   = var.subnet
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg, ]

  volume_tags = {
    Name = "dev-data"
  }
  tags = {
    Name = "dev-data"
  }
}
