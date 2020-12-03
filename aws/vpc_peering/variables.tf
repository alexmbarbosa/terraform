variable "region" {
  default = "us-east-1"
}

# VPC CIDR
variable "vpc_cidr" {
  default = "10.192.0.0/16"
}

# Public Subnets
variable "pubDEV1" {
  default = "10.192.10.0/24"
}

variable "pubDEV2" {
  default = "10.192.11.0/24"
}

# Private Subnets (APPs)
variable "prvDEV1" {
  default = "10.192.12.0/24"
}

variable "prvDEV2" {
  default = "10.192.13.0/24"
}

# Private Subnets (DBs)
variable "DBLayerPrivate1" {
  default = "10.0.21.0/24"
}

variable "DBLayerPrivate2" {
  default = "10.0.22.0/24"
}
