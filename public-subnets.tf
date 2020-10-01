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