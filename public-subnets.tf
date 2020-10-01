locals {
  az_names     = "${data.aws_availability_zones.azs.names}"
  pub_sub_ids  = "${aws_subnet.public.*.id}"
}


resource "aws_subnet" "public" {
  count                   = "${length(local.az_names)}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 3, count.index)}"
  vpc_id                  = "${aws_vpc.my_app.id}"
  availability_zone       = "${local.az_names[count.index]}"

  tags = {
    Name = "PublicSubnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.my_app.id}"

  tags = {
    Name = "terraform-gw"
  }
}

resource "aws_route_table" "prt" {
  vpc_id = "${aws_vpc.my_app.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "terraform-prt"
  }
}

resource "aws_route_table_association" "pub_sub_association" {
  count           = "${length(local.az_names)}"
  subnet_id       = "${local.pub_sub_ids[count.index]}"
  route_table_id  = "${aws_route_table.prt.id}"
}