locals {
  description = (length(var.cidr_blocks_extra) > 0) ? "Allow inbound traffic from ${local.client_sg_name} security group and extra CIDR blocks" : "Allow inbound traffic from ${local.client_sg_name} security group"
}

resource "aws_security_group_rule" "server-ingress" {
  source_security_group_id = aws_security_group.client.id
  type                     = "ingress"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.server.id
}

resource "aws_security_group_rule" "server-ingress-extra" {
  count = length(var.cidr_blocks_extra) > 0 ? 1 : 0

  cidr_blocks       = var.cidr_blocks_extra
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  security_group_id = aws_security_group.server.id
}

resource "aws_security_group" "server" {
  name        = local.server_sg_name
  description = local.description
  vpc_id      = data.aws_vpc.selected.id
  tags        = merge(var.tags, { "Name" = local.server_sg_name })

  lifecycle {
    ignore_changes = [description]
  }
}
