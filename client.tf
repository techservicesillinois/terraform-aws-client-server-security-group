resource "aws_security_group_rule" "client-egress" {
  source_security_group_id = aws_security_group.server.id
  type                     = "egress"
  security_group_id        = aws_security_group.client.id

  # Iterate over each rule.
  for_each = local.rule_map

  from_port = each.value.port
  to_port   = each.value.port
  protocol  = each.value.protocol
}

resource "aws_security_group" "client" {
  name        = local.client_sg_name
  description = "Allow outbound traffic to ${local.server_sg_name} security group"
  vpc_id      = data.aws_vpc.selected.id
  tags        = merge(var.tags, { Name = local.client_sg_name })

  lifecycle {
    ignore_changes = [description]
  }
}
