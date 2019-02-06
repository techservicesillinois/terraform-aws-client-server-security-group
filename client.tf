resource "aws_security_group_rule" "client-egress" {
  source_security_group_id = "${aws_security_group.server.id}"
  type                     = "egress"
  from_port                = "${var.port}"
  to_port                  = "${var.port}"
  protocol                 = "${var.protocol}"
  security_group_id        = "${aws_security_group.client.id}"
}

resource "aws_security_group" "client" {
  name        = "${local.client_sg_name}"
  description = "Allow outbound traffic to members of ${local.server_sg_name} security group"
  vpc_id      = "${var.vpc_id}"
  tags        = "${merge(var.tags, map("Name", local.client_sg_name))}"
}
