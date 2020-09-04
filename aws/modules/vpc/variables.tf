# VPC Variables -----------------------------------------------------
variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  default     = true
}

# Subnets Variables -----------------------------------------------------
variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  default     = "public"
}

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  default     = "private"
}

variable "database_subnet_suffix" {
  description = "Suffix to append to database subnets name"
  type        = string
  default     = "db"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  default     = []
}

variable "database_subnets" {
  description = "A list of database subnets"
  default     = []
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  default     = []
}


# Public Subnets --------------------------------------------------
variable "public1" {
  default = "10.0.0.0/24"
}

variable "public2" {
  default = "10.0.1.0/24"
}

# Private Subnets (APPs)
variable "privateApp1" {
  default = "10.0.10.0/24"
}

variable "privateApp2" {
  default = "10.0.11.0/24"
}

# Private Subnets (DBs)
variable "privateDB1" {
  default = "10.0.20.0/24"
}

variable "privateDB2" {
  default = "10.0.21.0/24"
}