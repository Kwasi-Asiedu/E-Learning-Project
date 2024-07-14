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

variable "project_name" {
  description = "Name of project"
  type        = string
}

variable "alb_sg" {
  description = "security group passed in from load balancer module"
  type        = any
}

variable "db_subnet_group_name" {
  description = "Subnet group name of database"
  type        = string
}

variable "private_subnets" {
  description = "private subnets called from vpc module"
  type        = list(any)
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
    condition     = length(var.password) >= 8
    error_message = "Characters should be more than 7"
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

variable "dt_vpc" {
  description = "vpc id passed in from vpc module"
  type        = string
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

variable "rds_sg_cidr" {
  description = "Vpc CIDR block passed in from vpc module"
  type        = string
}