resource "aws_security_group_rule" "server-ingress" {
  source_security_group_id = aws_security_group.client.id
  type                     = "ingress"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.server.id
}

resource "aws_security_group" "server" {
  name        = local.server_sg_name
  description = "Allow inbound traffic from ${local.client_sg_name} security group"
  vpc_id      = data.aws_vpc.selected.id
  tags        = merge(var.tags, { "Name" = local.server_sg_name })

  lifecycle {
    ignore_changes = [description]
  }
}
