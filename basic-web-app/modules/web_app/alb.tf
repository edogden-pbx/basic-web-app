# Load Balancer

module "alb" {
  source  = "terraform-aws-modules/alb/aws"

  name = "webApp-alb"

  load_balancer_type = "application"

  vpc_id             = data.aws_vpc.default_vpc.id
  subnets            = data.aws_subnet_ids.default_subnet.ids
  security_groups    = [module.security_group.alb_sg.security_group_id]

  target_groups = [
    {
      name_prefix      = "webApp-"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "instance"
      health_check = {
        enabled = true
        interval = 15
        path = "/"
        matcher = "200"
        timeout = 3
        healthy_threshold = 2
        unhealthy_threshold = 2
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0

      priority     = 100

      conditions = [{
        path_patterns = ["*"]
      }]
    }
  ]

  tags = {
    Environment = "Test"
  }

}

# Load Balancer Security

resource "aws_lb_listener" "http" {
  load_balancer_arn = module.alb.lb_arn

  port = 80

  protocol = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

module "security_group" "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"

  name        = "webApp-alb-security-group"
  description = "Security group for WebApp ALB"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

# ACM

# module "acm" {
#   source  = "terraform-aws-modules/acm/aws"

#   domain_name = var.domain
#   zone_id     = aws_route53_zone.primary.zone_id
# }