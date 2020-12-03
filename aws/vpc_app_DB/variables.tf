variable "region" {
  default = "us-east-1"
}

# VPC CIDR
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Public Subnets
variable "DMZpublic1" {
  default = "10.0.1.0/24"
}

variable "DMZpublic2" {
  default = "10.0.2.0/24"
}

# Private Subnets (APPs)
variable "AppLayerPrivate1" {
  default = "10.0.11.0/24"
}

variable "AppLayerPrivate2" {
  default = "10.0.12.0/24"
}

# Private Subnets (DBs)
variable "DBLayerPrivate1" {
  default = "10.0.21.0/24"
}

variable "DBLayerPrivate2" {
  default = "10.0.22.0/24"
}
