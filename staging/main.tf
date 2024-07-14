# VPC
module "Staging_VPC" {
  source                          = "../modules/vpc"
  vpc_cidr                        = var.vpc_cidr
  enable_dns_hostnames            = var.enable_dns_hostnames
  public_subnet_cidrs             = var.public_subnet_cidrs
  private_subnet_cidrs            = var.private_subnet_cidrs
  private_subnets                 = var.private_subnets
  public_subnets                  = var.public_subnets
  tags                            = var.tags
  instance_tenancy                = var.instance_tenancy
  map_public_ip_on_launch_public  = var.map_public_ip_on_launch_public
  map_public_ip_on_launch_private = var.map_public_ip_on_launch_private
  project_name                    = var.project_name
  open_cidr                       = var.open_cidr
}


# APPLICATION LOAD BALANCER
module "Staging_ALB" {
  source                     = "../modules/alb"
  dt_vpc_id                  = module.Staging_VPC.vpc_id
  alb_security_group_egress  = var.alb_security_group_egress
  alb_security_group_ingress = var.alb_security_group_ingress
  public_subnets             = module.Staging_VPC.public_subnets
  project_name               = var.project_name
  open_cidr                  = var.open_cidr
  alb_cidr                   = module.Staging_VPC.cidr_block
  http_port                  = var.http_port
  http_protocol              = var.http_protocol
  target_type                = var.target_type
  unhealthy_threshold        = var.unhealthy_threshold
  healthy_threshold          = var.healthy_threshold
  timeout                    = var.timeout
  interval                   = var.interval
  matcher                    = var.matcher
  path                       = var.path
}


# IAM ROLE
module "Staging_role" {
  source                  = "../modules/iamrole"
  ecs_task_execution_role = var.ecs_task_execution_role
}


# RDS
module "RDS" {
  source                       = "../modules/rds"
  allocated_storage            = var.allocated_storage
  db_name                      = var.db_name
  identifier                   = var.identifier
  engine                       = var.engine
  engine_version               = var.engine_version
  instance_class               = var.instance_class
  username                     = var.username
  password                     = var.password
  db_subnet_group_name         = var.db_subnet_group_name
  skip_final_snapshot          = var.skip_final_snapshot
  parameter_group_name         = var.parameter_group_name
  parameter_group_family       = var.parameter_group_family
  private_subnets              = module.Staging_VPC.private_subnets
  storage_encrypted            = var.storage_encrypted
  performance_insights_enabled = var.performance_insights_enabled
  alb_sg                       = module.Staging_ALB.alb_sg_id
  dt_vpc                       = module.Staging_VPC.vpc_id
  rds_sg_ingress               = var.rds_sg_ingress
  rds_sg_egress                = var.rds_sg_egress
  project_name                 = var.project_name
  rds_sg_cidr                  = module.Staging_VPC.cidr_block
}


# ECR
module "Staging_ecr" {
  source   = "../modules/ecr"
  ecr_name = var.ecr_name
}


# ECS
module "Staging_ECS" {
  source                         = "../modules/ecs"
  dt_ecs_cluster_name            = var.dt_ecs_cluster_name
  ecs_vpc_id                     = module.Staging_VPC.vpc_id
  ecr_repo_url                   = module.Staging_ecr.ecr_repo_url
  dt_ecs_task_family             = var.dt_ecs_task_family
  dt_ecs_task_name               = var.dt_ecs_task_name
  container_port                 = var.container_port
  ecs_task_execution_role        = module.Staging_role.ecs_task_execution_role
  aws_iam_role_policy_attachment = module.Staging_role.ecs_iam_role_policy_attachment
  aws_iam_policy_document        = module.Staging_role.iam_policy_document
  lb_target_group                = module.Staging_ALB.target-group
  dt_ecs_service_name            = var.dt_ecs_service_name
  ecs-lb                         = module.Staging_ALB.alb_sg_id
  ecs_priv_subs                  = module.Staging_VPC.private_subnets
  ecs_service_sg_ingress         = var.ecs_service_sg_ingress
  ecs_service_sg_egress          = var.ecs_service_sg_egress
  ecs_cidr_block                 = module.Staging_VPC.cidr_block
  project_name                   = var.project_name
  fargate_cpu                    = var.fargate_cpu
  fargate_memory                 = var.fargate_memory
  desired_count                  = var.desired_count
  ecs_prefix                     = var.ecs_prefix
  ecs_region                     = var.ecs_region
  log_group_name                 = module.Staging_cloudwatch.ecs_log_group_name
  ecs_service_public_ip          = var.ecs_service_public_ip
}


# CLOUDWATCH 
module "Staging_cloudwatch" {
  source          = "../modules/cloudwatch"
  log_stream_name = var.log_stream_name
  cloudwatch_tags = var.cloudwatch_tags
}


# ROUTE 53
module "Staging_route53" {
  source              = "../modules/route53"
  route_53_lb_zone_id = module.Staging_ALB.lb-zone-id
  route53_lb_dns_name = module.Staging_ALB.load_balancer_dns_name
  domain              = var.domain
  sub_domain          = var.sub_domain
}


# SSL CERTIFICATE
module "Staging_certificate" {
  source                    = "../modules/certificate"
  domain                    = var.domain
  subject_alternative_names = var.subject_alternative_names
}