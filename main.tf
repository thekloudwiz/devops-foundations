# Security Group
resource "aws_security_group" "web" {
  name        = "devops-foundations-web"
  description = "Allow HTTP traffic for DevOps Foundations demo"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "devops-foundations-web"
  }
}

# HTTP ingress
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"

  description = "Allow HTTP traffic"
}

# SSH ingress
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.web.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  description = "Allow SSH traffic"
}

# Allow outbound traffic
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.web.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"

  description = "Allow outbound traffic"
}

# EC2 instance
resource "aws_instance" "web" {
  ami = data.aws_ssm_parameter.al2023_ami.value

  instance_type = var.instance_type

  subnet_id = data.aws_subnets.default.ids[0]

  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  user_data = <<-EOF
    #!/bin/bash

    dnf update -y
    dnf install -y nginx

    systemctl enable nginx
    systemctl start nginx

    cat > /usr/share/nginx/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
    <head>
        <title>DevOps Foundations</title>
    </head>
    <body>
        <h1>Hello from Terraform!</h1>
        <p>Stage 2 - This EC2 instance was created as code.</p>
    </body>
    </html>
    HTML
  EOF

  tags = {
    Name = var.instance_name
  }
}

