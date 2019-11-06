output "client_security_group_id" {
  value = aws_security_group.client.id
}

output "client_security_group_name" {
  value = aws_security_group.client.name
}

output "server_security_group_id" {
  value = aws_security_group.server.id
}

output "server_security_group_name" {
  value = aws_security_group.server.name
}
