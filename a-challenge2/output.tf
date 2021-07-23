#output "db_server_private_ip" {
#  value = aws_instance.db_server.private_ip
#}

output "EIP" {
  value = aws_eip.web_server_eip.public_ip
}
