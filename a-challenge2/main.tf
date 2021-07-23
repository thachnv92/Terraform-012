resource "aws_vpc" "my_vpc" {
  cidr_block        = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.subnet_zone

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_network_interface" "my_network_interface_db" {
  subnet_id         = aws_subnet.my_subnet.id
  private_ips       = var.network_interface_private_ips["db_server"]
  
  tags = {
    Name = var.network_interface_name
  }
}

resource "aws_network_interface" "my_network_interface_web" {
  subnet_id         = aws_subnet.my_subnet.id
  private_ips       = var.network_interface_private_ips["web_server"]
  
  tags = {
    Name = var.network_interface_name
  }
}

resource "aws_security_group" "web_server" {
  name        = "allow_https"
  description = "Allow HTTP/HTTPS inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.my_vpc.cidr_block]
  }

  ingress {
    description      = "HTTPS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.my_vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-allow_http"
  }
}

resource "aws_instance" "db_server" {
  ami               = var.instance_ami["db_server"]
  instance_type     = var.instance_type["db_server"]

  network_interface {
    network_interface_id = aws_network_interface.my_network_interface_db.id
    device_index         = 0
  }
  
  credit_specification {
    cpu_credits = var.instance_cpu_credits
  }

  tags = {
    Name = var.instance_db_name["db_server"]
  }
}

output "db_server_private_ip" {
  value = aws_instance.db_server.private_ip
}

resource "aws_instance" "web_server" {
  ami               = var.instance_ami["web_server"]
  instance_type     = var.instance_type["web_server"]
#  security_groups   = [aws_security_group.web_server.name]

  network_interface {
    network_interface_id = aws_network_interface.my_network_interface_web.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = var.instance_cpu_credits
  }

  tags = {
    Name = var.instance_db_name["web_server"]
  }
}
