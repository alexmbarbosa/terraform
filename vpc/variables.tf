variable "region" {
  default = "us-east-1"
}

# VPC CIDR
variable "vpc_cidr" {
  default = "10.99.0.0/16"
}

# Public Subnets
variable "DMZ1public" {
  default = "10.99.1.0/24"
}

variable "DMZ2public" {
  default = "10.99.2.0/24"
}

# Private Subnets (APPs)
variable "AppLayer1private" {
  default = "10.99.11.0/24"
}

variable "AppLayer2private" {
  default = "10.99.12.0/24"
}

# Private Subnets (DBs)
variable "DBLayer1private" {
  default = "10.99.21.0/24"
}

variable "DBLayer2private" {
  default = "10.99.22.0/24"
}
