output "vpc_id" {
  value = module.Staging_VPC.vpc_id
}

output "load_balancer_dns_name" {
  value = module.Staging_ALB.load_balancer_dns_name
}

