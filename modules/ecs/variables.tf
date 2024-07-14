variable "dt_ecs_cluster_name" {
  description = "Name of cluster"
  type        = string
}

variable "ecs_vpc_id" {
  description = "VPC id passed in as variable from vpc module"
  type        = string
}

variable "dt_ecs_task_family" {
  description = "Task family name"
  type        = string
}

variable "dt_ecs_task_name" {
  description = "Name of task"
  type        = string
}

variable "ecr_repo_url" {
  description = "Repository url passed in as variable from ecr module"
  type        = string
}

variable "container_port" {
  description = "Listener port of container"
  type        = number
}

variable "ecs_task_execution_role" {
  type = any
}

variable "aws_iam_role_policy_attachment" {
  type = any
}

variable "aws_iam_policy_document" {
  type = any
}

variable "dt_ecs_service_name" {
  type = string
}

variable "lb_target_group" {
  description = "Target group arn passed in as variable from alb module"
  type        = any
}

variable "ecs_priv_subs" {
  description = "Private subnets passed in as variable from vpc module"
  type        = list(any)
}

variable "ecs_service_sg_ingress" {
  description = "Inbound traffic into ecs"
  type = list(object({
    description = string
    port        = number
    protocol    = string
  }))

}

variable "ecs_service_sg_egress" {
  description = "Outbound traffic from ecs"
  type = list(object({
    description = string
    port        = number
    protocol    = string
  }))

}

variable "ecs-lb" {
  description = "Load balancer security group passed in as variable from alb module"
  type        = any
}

variable "project_name" {
  type = string
}

variable "fargate_cpu" {
  type = number
}

variable "fargate_memory" {
  type = number
}

variable "ecs_cidr_block" {
  description = "VPC CIDR block passed in as variable from vpc module"
  type        = any
}

variable "desired_count" {
  description = "Number of tasks running in ECS service"
  type        = number
}

variable "log_group_name" {
  description = "Log group name passed in as variable from cloudwatch module"
  type        = string
}

variable "ecs_region" {
  description = "Region where ECS is being provisioned"
  type        = string
}

variable "ecs_prefix" {
  description = "Prefix to be detected for logs"
  type        = string
}

variable "ecs_service_public_ip" {
  description = "Toggle for ecs public ip"
  type = bool
}



