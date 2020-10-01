locals {
  az_names = "${data.aws_availability_zones.azs.names}"
}


resource "aws_subnet" "public" {
  count                   = "${length(local.az_names)}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"
  vpc_id                  = "${aws_vpc.my_app.id}"
  availability_zone       = "${local.az_names[count.index]}"

  tags = {
    Name = "PublicSubnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.my_app.id}"
  Name   = "terraform-igw"
}

resource "aws_route_table" "prt" {
  vpc_id = ""

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "terraform-prt"
  }
}