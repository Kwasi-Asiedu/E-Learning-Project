variable "route53_lb_dns_name" {
  description = "Load balancer dns name passed in as variable from alb module"
  type        = any
}

variable "route_53_lb_zone_id" {
  description = "zone id of domain(kwasipizza.click)"
  type        = any
}

variable "domain" {
  description = "Domain"
  type        = string
}

variable "sub_domain" {
  description = "sub domain"
  type        = string
}