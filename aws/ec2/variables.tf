variable "region" {
  default = "us-east-1"
}

variable "vpc" {
  default = ""
}

variable "image" {
  default = "ami-04bf6dcdc9ab498ca"     #> AMI AMZN2
  #default = "ami-0885b1f6bd170450c"    #> AMI UBUNTU
}

variable "subnet" {
  default = ""
}

variable "type" {
  default = "t2.micro"
}

variable "keypair" {
  default = ""
}

variable "sg" {
  default = ""
}
