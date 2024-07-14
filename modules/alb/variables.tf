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

variable "project_name" {
  description = "Name of project"
  type        = string
}

variable "open_cidr" {
  description = "allows all access"
  type        = string
}


variable "dt_vpc_id" {
  description = "vpc id called from vpc module"
  type        = string
}

variable "public_subnets" {
  description = "public subnets called from vpc module"
  type        = list(any)
}

variable "alb_cidr" {
  description = "Vpc CIDR passed in as variable from vpc module"
  type        = string
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