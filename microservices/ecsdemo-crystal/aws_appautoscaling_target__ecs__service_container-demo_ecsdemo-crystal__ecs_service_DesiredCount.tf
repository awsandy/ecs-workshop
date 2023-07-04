# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_appautoscaling_target.ecs__service_container-demo_ecsdemo-crystal__ecs_service_DesiredCount:
resource "aws_appautoscaling_target" "ecs__service_container-demo_ecsdemo-crystal__ecs_service_DesiredCount" {
  max_capacity       = 10
  min_capacity       = 3
  resource_id        = "service/container-demo/ecsdemo-crystal"
  role_arn           = format("arn:aws:iam::%s:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService", data.aws_caller_identity.current.account_id)
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  tags               = {}
  tags_all           = {}
}