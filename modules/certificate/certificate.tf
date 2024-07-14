# SSL Certificate Request
resource "aws_acm_certificate" "dt_certificate" {
  domain_name               = var.domain
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"
}


# Reading Hosted zone
data "aws_route53_zone" "dt_zone" {
  name         = var.domain
  private_zone = false
}


# Creating DNS Record in Route 53
resource "aws_route53_record" "dt_ssl_record" {
  for_each = {
    for dvo in aws_acm_certificate.dt_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.dt_zone.zone_id
}


# SSL Certificate validation
resource "aws_acm_certificate_validation" "dt_validation" {
  certificate_arn         = aws_acm_certificate.dt_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.dt_ssl_record : record.fqdn]
}
