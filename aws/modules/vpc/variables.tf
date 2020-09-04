# VPC CIDR
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Public Subnets
variable "public1" {
  default = "10.0.1.0/24"
}

variable "public2" {
  default = "10.0.2.0/24"
}

# Private Subnets (APPs)
variable "privateApp1" {
  default = "10.0.11.0/24"
}

variable "privateApp2" {
  default = "10.0.12.0/24"
}

# Private Subnets (DBs)
variable "privateDB1" {
  default = "10.0.21.0/24"
}

variable "privateDB2" {
  default = "10.0.22.0/24"
}
