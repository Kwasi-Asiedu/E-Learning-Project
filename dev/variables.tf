# ••••• Region ••••• 
variable "region" {
  description = "Region for deployment"
  type        = string 
} 



# ••••• VPC ••••• 
variable "tags" {
  description = "Tags for VPC"
  type        = map(any)
}

variable "enable_dns_hostnames" {
  description = "Toggle for dns hostnames"
  type        = bool
}

variable "instance_tenancy" {
  description = "Tenancy of instance"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR of VPC"
  type        = string
}

variable "map_public_ip_on_launch_public" {
  description = "Toggle for IP address allocation"
  type        = bool
}

variable "map_public_ip_on_launch_private" {
  description = "Toggle for IP address allocation"
  type        = bool
}

variable "open_cidr" {
  description = "allows all access"
  type        = string
}

variable "project_name" {
  description = "Name of project"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR of public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR of private subnets"
  type        = list(string)
}



# ••••• ALB ••••• 
variable "alb_security_group_ingress" {
  description = "Inbound traffic into load balancer"
  type = list(object({
    description = string
    port        = number
    protocol    = string
  }))
}

variable "alb_security_group_egress" {
  description = "Outbound traffic from load balancer"
  type = list(object({
    description = string
    port        = number
    protocol    = string
  }))
}


variable "http_port" {
  description = "HTTP port"
  type        = number
}

variable "http_protocol" {
  description = "HTTP protocol"
  type        = string
}

variable "target_type" {
  description = "Target type"
  type        = string
}

variable "healthy_threshold" {
  description = "Number of consecutive successful healthchecks for target to be deemed healthy"
  type        = number
}

variable "unhealthy_threshold" {
  description = "Number of consecutive failed healthchecks for target to be deemed unhealthy"
  type        = number
}

variable "interval" {
  description = "Time between consecutive health checks"
  type        = number
}

variable "timeout" {
  description = "Response time of target"
  type        = number
}

variable "matcher" {
  description = "Code to indicate healthcheck success"
  type        = string
}

variable "path" {
  description = "Destination of health check request"
  type        = string
}



# ••••• RDS •••••
variable "db_subnet_group_name" {
  description = "Subnet group name of database"
  type        = string
}

variable "db_name" {
  description = "Name of database"
  type        = string
}

variable "engine" {
  description = "Type of sql engine being used"
  type        = string
}

variable "engine_version" {
  description = "Engine version running"
  type        = string
}

variable "instance_class" {
  description = "Instance class of database"
  type        = string
}

variable "username" {
  description = "Username of user"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.username) > 4
    error_message = "Username should be longer than 4 characters"
  }
}

variable "password" {
  description = "password of user"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.password) > 8
    error_message = "Characters should be more than 8"
  }
}

variable "allocated_storage" {
  description = "Storage capacity of database"
  type        = number
}

variable "parameter_group_name" {
  description = "parameter group name of database"
  type        = string
}

variable "parameter_group_family" {
  description = "parameter group family of database"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Final shot toggle"
  type        = bool
}

variable "rds_sg_ingress" {
  description = "Inbound traffic into rds"
  type = list(object({
    description = string
    port        = number
    protocol    = string
  }))
}

variable "rds_sg_egress" {
  description = "Outbound traffic from rds"
  type = list(object({
    description = string
    port        = number
    protocol    = string
  }))
}

variable "identifier" {
  description = "identifier of database"
  type        = string
  validation {
    condition     = can(regex("^([a-z0-9.-]+)$", var.identifier))
    error_message = "Identifier can only contain lowercase alphanumeric characters, periods, and hyphens."
  }

}

variable "storage_encrypted" {
  description = "database encryption toggle"
  type        = bool
}

variable "performance_insights_enabled" {
  description = "Performance insights toggle"
  type        = bool
}



# ••••• ECR ••••• 
variable "ecr_name" {
  description = "Repository name"
  type        = string
}



# ••••• ECS •••••
variable "ecs_task_execution_role" {
  description = "Task execution role of ECS"
  type        = string
}

variable "dt_ecs_cluster_name" {
  description = "Name of ECS cluster"
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

variable "container_port" {
  description = "Listener port of container"
  type        = number
}

variable "dt_ecs_service_name" {
  description = "Service name of cluster"
  type        = string
}

variable "desired_count" {
  description = "Number of tasks running in ECS service"
  type        = number
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

variable "fargate_cpu" {
  description = "CPU of fargate"
  type        = number
}

variable "fargate_memory" {
  description = "Memory of fargate"
  type        = number
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
  type        = bool
}



# ••••• Cloudwatch •••••
variable "cloudwatch_tags" {
  description = "Tag of cloudwatch group"
  type        = map(any)
}

variable "log_stream_name" {
  description = "Name of cloudwatch log stream"
  type        = string
}



# ••••• Route53 •••••
variable "domain" {
  description = "Domain"
  type        = string
}

variable "sub_domain" {
  description = "sub domain"
  type        = string
}

variable "subject_alternative_names" {
  description = "Alternate domain names"
  type        = list(string)
}

