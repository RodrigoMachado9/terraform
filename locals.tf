locals {
  vpc_name = "${terraform.workspace == "dev"? "vpc-dev" : "vpc-prod"}"
}

resource "aws_vpc" "my_vpc" {
  count            = "${terraform.workspace == "dev"? 0:1}"
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags = {
    Name = "${local.vpc_name}"
    Environment = "${terraform.workspace}"
    Location    = "India"
  }
}

//output "vpc_cidr" {
//  value = "${aws_vpc.my_vpc.cidr_block}"
//}
