resource "aws_key_pair" "ssh_key" {
  key_name        = var.key_name
  public_key      = var.public_key
  
  tags = {
    Name          = "DevOps"
  }
}

resource "aws_instance" "public" {
  count           = var.instance_count

  ami             = var.ami
  tenancy         = var.tenancy
  instance_type   = var.instance_type
  key_name        = aws_key_pair.ssh_key.id
  subnet_id       = ""
  associate_public_ip_address = true
  vpc_security_group_ids = [ "" ]

  user_data = <<-EOT
    #!/bin/bash
    sudo yum -y update
    sudo yum -y install telnet nmap mlocate screen curl jq
  EOT

  tags = merge(
    {
      "Name"      = var.instance_count > 1 || var.use_num_suffix ? format("%s${var.num_suffix_format}", var.name, count.index + 1) : var.name
    },
    var.tags,
  )

  volume_tags     = merge(
    {
      "Name"      = var.instance_count > 1 || var.use_num_suffix ? format("%s${var.num_suffix_format}", var.name, count.index + 1) : var.name
    },
    var.volume_tags,
  )

}
