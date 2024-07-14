# Region for infrastructure deployment
region = "us-west-1"


# VPC 
vpc_cidr                        = "10.0.0.0/16"
enable_dns_hostnames            = true
map_public_ip_on_launch_public  = true
map_public_ip_on_launch_private = false
project_name                    = "alpha"
tags = {
  Name : "alpha_VPC"
  Environment : "dev"
}
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
public_subnets       = ["public_subnet_1", "public_subnet_2"]
private_subnets      = ["private_subnet_1", "private_subnet_2"]
instance_tenancy     = "default"
open_cidr            = "0.0.0.0/0"


# ALB
alb_security_group_ingress = [{
  description = "Allows HTTP"
  port        = 80
  protocol    = "tcp"
}]

alb_security_group_egress = [{
  description = "Outbound traffic"
  port        = 0
  protocol    = "-1"
}]
http_port           = 80
http_protocol       = "HTTP"
target_type         = "ip"
healthy_threshold   = 2
unhealthy_threshold = 2
timeout             = 5
interval            = 6
matcher             = "200"
path                = "/"


#RDS
db_subnet_group_name         = "alpha_db_subnet_group"
identifier                   = "alpha-db"
db_name                      = "alpha"
engine                       = "postgres"
engine_version               = "16"
instance_class               = "db.t3.micro"
allocated_storage            = 20
parameter_group_name         = "alpha-parameter-group"
parameter_group_family       = "postgres16"
skip_final_snapshot          = true
storage_encrypted            = true
performance_insights_enabled = true
username                     = "crazywayss"
password                     = "dontprovokeme"
rds_sg_ingress = [
  {
    description = "PostgreSQL port"
    port        = 5432
    protocol    = "tcp"
}]
rds_sg_egress = [{
  description = "outbound traffic outlet"
  port        = 0
  protocol    = "-1"
}]


# S3
bucket_name = "alpha-bucket"
backend_tags = {
  "Name"      = "alpha_bucket"
  Environment = "Dev"
}

# DynamoDB table
table_name = "alpha_table"

# ECR
ecr_name = "e-learning-repo"


# ECS
ecs_task_execution_role = "alpha_role"
dt_ecs_cluster_name     = "alpha_ecs_cluster"
dt_ecs_service_name     = "alpha_service"
dt_ecs_task_family      = "alpha_family"
dt_ecs_task_name        = "alpha_container"
container_port          = 80
desired_count           = 1
fargate_cpu             = 256
fargate_memory          = 512
ecs_service_sg_ingress = [{
  description = "Allows HTTP"
  port        = 80
  protocol    = "tcp"
  }
]
ecs_service_sg_egress = [{
  description = "Outbound traffic"
  protocol    = "-1"
  port        = 0
}]
ecs_prefix            = "ecs"
ecs_region            = "us-west-1"
ecs_service_public_ip = false


# Cloudwatch
log_stream_name = "alpha_log_stream"
cloudwatch_tags = {
  Name : "alpha_log_group"
  Environment : "dev"
}


# Route53
domain                    = "kwasipizza.click"
sub_domain                = "*.kwasipizza.click"
subject_alternative_names = ["*.kwasipizza.click"]