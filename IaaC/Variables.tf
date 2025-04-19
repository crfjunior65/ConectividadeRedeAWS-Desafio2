variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for resource naming"
  default     = "bia"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  description = "List of availability zones"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ecs_instance_type" {
  description = "Instance type for ECS nodes"
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  default     = "bia-key"
}

variable "db_name" {
  description = "RDS database name"
  default     = "bia"
}

variable "db_username" {
  description = "RDS database username"
  default     = "postgres"
}

variable "db_password" {
  description = "RDS database password"
  sensitive   = true
  default     = "postgres"
}

variable "db_instance_class" {
  description = "RDS instance class"
  default     = "db.t3.micro"
}

variable "bia_dev_ami" {
  description = "AMI ID for bia-dev instance"
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
}

variable "bia_dev_instance_type" {
  description = "Instance type for bia-dev"
  default     = "t3.micro"
}
/*
variable "bia_dev_ami_2023" {
  description = "AMI ID for bia-dev instance Amazon Linux 2023"
  default     = data.aws_ami.amazon_linux_2023.id
}
*/