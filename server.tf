resource "aws_security_group_rule" "server-ingress" {
  source_security_group_id = "${aws_security_group.client.id}"
  type                     = "ingress"
  from_port                = "${var.port}"
  to_port                  = "${var.port}"
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.server.id}"
}

resource "aws_security_group" "server" {
  name        = "${local.server_sg_name}"
  description = "Allow inbound traffic from members of ${local.client_sg_name} security group"
  vpc_id      = "${var.vpc_id}"
  tags        = "${merge(var.tags, map("Name", local.server_sg_name))}"
}
