#############################################################
## Creates the Route53 reources for our WebApp 
#############################################################

# Creates Route53 Zone with domain
resource "aws_route53_zone" "primary" {
  name = var.domain
}

# Creates A and AAAA DNS records on the root of the domain to the ALB
resource "aws_route53_record" "root" {
  for_each = toset(["A", "AAAA"])

  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain
  type    = each.key

  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}

# Creates A and AAAA DNS records on the www. domain to the ALB
resource "aws_route53_record" "www" {
  for_each = toset(["A", "AAAA"])

  zone_id = aws_route53_zone.primary.zone_id
  name    = "www"
  type    = each.key

  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}