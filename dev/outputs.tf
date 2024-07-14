output "vpc_id" {
  value = module.Dev_VPC.vpc_id
}

output "load_balancer_dns_name" {
  value = module.Dev_ALB.load_balancer_dns_name
}

