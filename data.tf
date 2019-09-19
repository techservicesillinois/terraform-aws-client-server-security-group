locals {
  client_sg_name = "${var.name_prefix == "" ? var.client_sg_name : format("%s-clients", var.name_prefix)}"
  server_sg_name = "${var.name_prefix == "" ? var.server_sg_name : format("%s-servers", var.name_prefix)}"
}

data "aws_vpc" "selected" {
  tags {
    Name = "${var.vpc}"
  }
}
