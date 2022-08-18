#############################################################
## Creates the Route53 reources for our WebApp 
#############################################################

# Creates Route53 Zone with domain
resource "aws_route53_zone" "primary" {
  count = var.create_dns_zone ? 1 : 0
  name = var.domain
}


# Get Route53 Zone
data "aws_route53_zone" "primary" {
  count = var.create_dns_zone ? 0 : 1
  name  = var.domain
}

# Set Route53 Zone ID
locals {
  dns_zone_id = var.create_dns_zone ? aws_route53_zone.primary[0].zone_id : data.aws_route53_zone.primary[0].zone_id
  subdomain   = var.environment == "production" ? "" : "${var.environment}."
}

# Creates A and AAAA DNS records on the root of the domain to the ALB
resource "aws_route53_record" "root" {
  for_each = toset(["A", "AAAA"])

  zone_id = local.dns_zone_id
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

  zone_id = local.dns_zone_id
  name    = "www"
  type    = each.key

  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}