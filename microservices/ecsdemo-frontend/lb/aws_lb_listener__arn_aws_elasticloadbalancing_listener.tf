# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_lb_listener.arn_aws_elasticloadbalancing_eu-west-2_566972129213_listener_app_ecswo-Front-1M69OSRSV4E9Z_65bb782bf8b1d07b_608ff6afe838ec0e:
resource "aws_lb_listener" "arn_aws_elasticloadbalancing_eu-west-2_566972129213_listener_app_ecswo-Front-1M69OSRSV4E9Z_65bb782bf8b1d07b_608ff6afe838ec0e" {
  load_balancer_arn = aws_lb.arn_aws_elasticloadbalancing_eu-west-2_566972129213_loadbalancer_app_ecswo-Front-1M69OSRSV4E9Z_65bb782bf8b1d07b.arn
  port              = 80
  protocol          = "HTTP"
  tags              = {}
  tags_all          = {}

  default_action {
    target_group_arn = aws_lb_target_group.arn_aws_elasticloadbalancing_eu-west-2_566972129213_targetgroup_ecswor-Front-VWZBXC2NOHYZ_980ebe2e449dec23.arn
    type             = "forward"
  }
}