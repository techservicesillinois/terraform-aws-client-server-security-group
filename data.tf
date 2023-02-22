locals {
  client_sg_name = var.name_prefix == null ? var.client_sg_name : format("%s-clients", var.name_prefix)
  server_sg_name = var.name_prefix == null ? var.server_sg_name : format("%s-servers", var.name_prefix)
}

data "aws_vpc" "selected" {
  tags = {
    Name = var.vpc
  }
}

locals {
  # Restructure rules for the for_each statement.

  rules = flatten([
    for protocol, ports in var.rules : [
      for port in ports : {
        key      = format("%s:%d", protocol, port)
        port     = port
        protocol = protocol
      }
    ]
  ])
}

locals {
  rule_map = { for r in local.rules : r.key => r }
}
