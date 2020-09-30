provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "my_vpc" {
  count = 0
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags = {
    Name = "terraform-vpc"
    Environment = "${terraform.workspace}"
    Location = "India"
  }
}

//output "vpc_cidr" {
//  value = "${aws_vpc.my_vpc.cidr_block}"
//}


terraform {
  backend "s3" {
    bucket = "myterraforms3"
    key = "terraform.tfstate"
    region = "us-west-2"
     dynamodb_table = "terraform-dynamodb"

  }
}
