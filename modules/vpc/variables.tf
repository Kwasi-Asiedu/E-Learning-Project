variable "vpc_cidr" {
  description = "CIDR block of vpc"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Toggle for vpc dns hostname"
  type        = bool
}

variable "tags" {
  description = "vpc tags"
  type        = map(any)
}

variable "project_name" {
  description = "Name of project"
  type        = string
}

variable "instance_tenancy" {
  description = "Tenancy of instance"
  type        = string
}

variable "public_subnets" {
  description = "Names of public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "Names of private subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR block of public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR block of private subnets"
  type        = list(string)
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
  description = "allows access from anywhere"
  type        = string
}