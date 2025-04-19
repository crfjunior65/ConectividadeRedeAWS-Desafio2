/*
output "ecs_cluster_name" {
  value = module.ecs_cluster.ecs_cluster_name
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "bia_dev_public_ip" {
  value = module.bia_dev_instance.instance_public_ip
}
*/
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnet_ids
}