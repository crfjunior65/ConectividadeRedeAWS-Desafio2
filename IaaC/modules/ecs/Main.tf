resource "aws_ecs_cluster" "bia_cluster" {
  name = "${var.project_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_launch_configuration" "ecs_launch_config" {
  name_prefix          = "${var.project_name}-ecs-node-"
  image_id             = data.aws_ami.ecs_optimized.id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.name
  key_name             = var.key_name
  security_groups      = [aws_security_group.ecs_instance_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo ECS_CLUSTER=${aws_ecs_cluster.bia_cluster.name} >> /etc/ecs/ecs.config
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs_asg" {
  name                 = "${var.project_name}-ecs-asg"
  launch_configuration = aws_launch_configuration.ecs_launch_config.name
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  vpc_zone_identifier  = var.public_subnet_ids

  tag {
    key                 = "Name"
    value               = "${var.project_name}-ecs-node"
    propagate_at_launch = true
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = ""
    propagate_at_launch = true
  }
}

# IAM Role para instâncias ECS
resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.project_name}-ecs-instance-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attachment" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "${var.project_name}-ecs-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}

# Security Group para instâncias ECS
resource "aws_security_group" "ecs_instance_sg" {
  name        = "${var.project_name}-ecs-instance-sg"
  description = "Security group for ECS instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ecs-instance-sg"
  }
}

data "aws_ami" "ecs_optimized" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}