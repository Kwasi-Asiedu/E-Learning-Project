# Fetching hosted zone
data "aws_route53_zone" "dt_zone" {
  name         = var.domain
  private_zone = false
}


# Reord creation 1
resource "aws_route53_record" "dt_record" {
  zone_id = data.aws_route53_zone.dt_zone.zone_id
  name    = data.aws_route53_zone.dt_zone.name
  type    = "A"


  alias {
    name                   = var.route53_lb_dns_name
    zone_id                = var.route_53_lb_zone_id
    evaluate_target_health = true
  }
}


# Record creation 2
resource "aws_route53_record" "dt_record_2" {
  zone_id = data.aws_route53_zone.dt_zone.zone_id
  name    = "*.kwasipizza.click"
  type    = "A"


  alias {
    name                   = var.route53_lb_dns_name
    zone_id                = var.route_53_lb_zone_id
    evaluate_target_health = true
  }
}





