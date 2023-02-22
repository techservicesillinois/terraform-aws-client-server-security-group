locals {
  description = (length(var.cidr_blocks_extra) > 0) ? "Allow inbound traffic from ${local.client_sg_name} security group and extra CIDR blocks" : "Allow inbound traffic from ${local.client_sg_name} security group"
}

resource "aws_security_group_rule" "server-ingress" {
  source_security_group_id = aws_security_group.client.id
  type                     = "ingress"
  security_group_id        = aws_security_group.server.id

  # Iterate over each rule.
  for_each = local.rule_map

  from_port = each.value.port
  to_port   = each.value.port
  protocol  = each.value.protocol
}

resource "aws_security_group_rule" "server-ingress-extra" {
  cidr_blocks       = var.cidr_blocks_extra
  security_group_id = aws_security_group.server.id
  type              = "ingress"

  for_each = length(var.cidr_blocks_extra) > 0 ? local.rule_map : {}

  from_port = each.value.port
  to_port   = each.value.port
  protocol  = each.value.protocol
}

resource "aws_security_group" "server" {
  name        = local.server_sg_name
  description = local.description
  vpc_id      = data.aws_vpc.selected.id
  tags        = merge(var.tags, { Name = local.server_sg_name })

  lifecycle {
    ignore_changes = [description]
  }
}
