# Create the Security Group
resource "aws_security_group" "sgSSH" {
  vpc_id       = aws_vpc.opsVpc.id
  name         = "sgSSH"
  description  = "SSH Security Group"
  
  # allow ingress of port 22
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  } 
  
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sgSSH"
    Description = "Allows SSH access"
  }
}
