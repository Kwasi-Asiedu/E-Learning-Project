output "load_balancer_dns_name" {
  value = aws_alb.dt_alb.dns_name
}

output "alb_sg_id" {
  value = aws_alb.dt_alb.security_groups
}

output "target-group" {
  value = aws_lb_target_group.dt_tg.arn
}

output "lb-zone-id" {
  value = aws_alb.dt_alb.zone_id
}