# Security Groups
resource "aws_security_group" "bia_dev" {
  name        = "${var.project_name}-bia-dev-sg"
  description = "Security group for BIA dev instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restringir para seu IP em produção
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-bia-dev-sg"
  }
}
