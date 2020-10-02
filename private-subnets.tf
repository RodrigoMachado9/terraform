resource "aws_subnet" "private" {
  count                   = "${length(slice(local.az_names, 0, 2))}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 3, count.index + length(local.az_names))}"
  vpc_id                  = "${aws_vpc.my_app.id}"
  availability_zone       = "${local.az_names[count.index]}"

  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}

resource "aws_instance" "nat" {
  ami                         = "${var.nat_amis[var.region]}"
  instance_type               = "t2.micro"
  subnet_id                   = "${local.pub_sub_ids[0]}"

  source_dest_check           = false
  vpc_security_group_ids = ["${aws_security_group.nat_seg.id}"]

  tags = {
    Name = "terraform-nat"
  }
}

resource "aws_route_table" "privatert" {
  vpc_id = "${aws_vpc.my_app.id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }

  tags = {
    Name = "terraform-privatert"
  }
}


resource "aws_route_table_association" "private_rt_association" {
  count           = "${length(slice(local.az_names, 0, 2))}"
  subnet_id       = "${aws_subnet.private.*.id[count.index]}"
  route_table_id  = "${aws_route_table.privatert.id}"

}

resource "aws_security_group" "nat_seg" {
  name = "nat_seg"
  description = "Allow traffic for private subnets"
  vpc_id = "${aws_vpc.my_app.id}"

//  ingress {
//    # TLS (change to whatever ports you need)
//    from_port = 443
//    to_port = 443
//    protocol = "-1"
//    # Please restrict your ingress to only necessary IPs and ports.
//    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
//    cidr_blocks = []
//  }


  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}