provider "aws" {
  region = "us-west-2"
}



terraform {
  backend "s3" {
    bucket          = "myterraforms3"
    key             = "terraform.tfstate"
    region          = "us-west-2"
    dynamodb_table  = "terraform-dynamodb"

  }
}
