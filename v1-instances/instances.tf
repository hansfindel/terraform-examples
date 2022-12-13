resource "aws_security_group" "app_server" {
  name   = "security-group-app-server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All Ports Egress"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.app_server.id
  vpc      = false
}

resource "aws_instance" "app_server" {
  ami           = "ami-0eea504f45ef7a8f7"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.app_server.id]

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
