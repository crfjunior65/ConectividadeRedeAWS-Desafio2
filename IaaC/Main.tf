/*
provider "aws" {
  region = var.region
}
*/

module "vpc" {
  source = "./modules/vpc"

  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}
/*
module "ecs_cluster" {
  source = "./modules/ecs"

  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  instance_type     = var.ecs_instance_type
  key_name          = var.key_name
}

module "rds" {
  source = "./modules/rds"

  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  db_instance_class  = var.db_instance_class
}

module "bia_dev_instance" {
  source = "./modules/ec2"

  project_name    = var.project_name
  instance_name   = "bia-dev"
  instance_count  = 1
  ami             = var.bia_dev_ami
  instance_type   = var.bia_dev_instance_type
  subnet_id       = module.vpc.public_subnet_ids[1] # Zona B
  key_name        = var.key_name
  security_groups = [module.vpc.bia_dev_sg_id]
  user_data       = file("${path.module}/scripts/lancar_ec2_zona_a.sh")
}
*/
