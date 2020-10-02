variable "vpc_cidr" {
  description = "Choose cidr vpc"
  type = "string"
  default = "10.20.0.0/16"
}

variable "region" {
  description = "Choose region for your stack"
  type        = "string"
  default     = "us-west-2"
}



variable "nat_amis" {
  type  = "map"
  default = {
    us-west-2 =  "ami-005e54dee72cc1d00"

  }
}

