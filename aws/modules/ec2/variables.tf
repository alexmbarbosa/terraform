//SSH KeyPair --------------------------------------------------
variable "create_key_pair" {
  description = "Controls if key pair should be created"
  default     = false
}

variable "key_name" {
  description = "SSH keys name."
  default     = "aolinux"
}

variable "public_key" {
  description = "The public SSH string."
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC37MzsbDji/2F4Ts586hyhmq5wLJQidYxk32G4HkNs64zuEp0nVlqi63X8rgkiRmVlGXECcOu0dXULM2Gy758Daa6lKEnDEdz8hcxJFEzIimXF9zJkT4WA9D21GIXZfrM4gImO4ctNG90Nw6uh58jea8spW0J8ZDxmeEp6BKr959MvBXbk37ffCovJhCJLyafTGV1tR0EvWMQ33Hm+jPiVPO3ZJYP4aS56DquEcm7nNuaHYpvHnpi5G49NzRQOV6KR6JHVBm0sT8IudtwZ+f0VvW+GE+W0TQlDCEqLJPadSox5ELRlrBbC1WVHJKr0doGGDrwh5DfaWHdV8gsLq1r3jWh/N2oNalWN5ROFW9bm1KZEWpmBghUVFY/QSXON9IRebWUo89eWqzmJrOjK/FGg8D23uJ3wUTLgJHcRerC6h4vPE86yanMOP3e+zUcRChKLF7Dc2Z4RJl2CL1eTpBZiJD769HcJmIJyNLX1DwOCv3n7A4kyXCTMxRFms2XA5XsWML3j9jfdrtvaG4mj7SbBpHOaWIKinN9CLpTI9Fz2lT6UXxff6UW86NkchOUVcKGNx1Ygi/sdVLC2l5I/57VrGd6Xk9vVcBSQg2uupXFdNbc/76MB/paXRbWcTLuDXm01lFb4JRGxdt3TrOoMjshV6dWNboiJcQSSXTsL5j7nGQ=="
}

//EC2 Instance --------------------------------------------------
variable "instance_count" {
  description = "Total instances to be created."
  default     = 1
}

variable "use_num_suffix" {
  description = "Always append numerical suffix to instance name, even if instance_count is 1"
  default     = true
}

variable "num_suffix_format" {
  description = "Numerical suffix format used as the volume and EC2 instance name suffix"
  default     = "%1d"
}

variable "name" {
  description = "Name to be used on all EC2 Instances as prefix"
  default     = "awslab"
}

variable "ami" {
  description = "Amazon Image for instances."
  default     = "ami-0cebb45b34604efb8"
}

variable "instance_type" {
  description = "Classes type for instances."
  default     = "t2.micro"
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  default     = {}
}

//VPC Virtual Private Cloud Relation ----------------------------
variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  default     = null
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  default     = ""
}

variable "subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  default     = []
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  default     = null
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  default     = []
}

//Available tenancy values: default, dedicated, host.
variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC)."
  default     = "default"
}
