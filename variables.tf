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

variable "web_ec2_count" {
  description = "Choose number ec2 instances for web"
  type        = "string"
  default     = "2"
}



variable "nat_amis" {
  type  = "map"
  default = {
    us-west-2 =  "ami-005e54dee72cc1d00"

  }
}

variable "web_amis" {
  type  = "map"
  default = {
    us-west-2 =  "ami-005e54dee72cc1d00"
  }
}

variable "web_instance_type" {
  description = "Choose instance type for your web"
  type        = "string"
  default     = "t2.micro"
}

variable "web_tags" {
  type = "map"
  default = {
    Name        = "WebServer"
//    Environment = "Dev"
  }
}


