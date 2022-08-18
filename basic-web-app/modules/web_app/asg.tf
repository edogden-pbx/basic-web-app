module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  
  name = "webApp-asg"
  min_size = var.min_instances
  max_size = var.max_instances
  health_check_type = "EC2"
  vpc_zone_identifier = module.vpc.vpc_id

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  launch_template_name        = "webApp-lt"
  launch_template_description = "Launch template for WebApp"
  update_default_version      = true

  image_id          = var.ami
  instance_type     = var.instance_type
  ebs_optimized     = true
  enable_monitoring = true

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              python3 -m http.server 8080 &
              EOF

  # IAM role & instand profile
  create_iam_instance_profile = true
  iam_role_name               = "webAppASG"
  iam_role_path               = "/ec2/"
  iam_role_description        = "IAM role for WebApp"
  iam_role_tags = {
    CustomIamRole = "Yes"
  }
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  target_group_arns = [module.alb.lb_arn]

  tags = {
    Terraform = "true"
    Environment = var.environment
  }

}

# Security

module "asg_security_group" {
  source  = "terraform-aws-modules/security-group/aws"

  name        = "webApp-security-group"
  description = "Security group for WebApp EC2"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-8080-tcp"]
  egress_rules        = ["all-all"]
}