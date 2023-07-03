# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_ecs_capacity_provider.EC21615645663:
resource "aws_ecs_capacity_provider" "EC21615645663" {
  name     = "EC21615645663"
  tags     = {}
  tags_all = {}

  auto_scaling_group_provider {
    auto_scaling_group_arn         = "arn:aws:autoscaling:eu-west-2:566972129213:autoScalingGroup:33cb60c7-8845-4aa9-9d37-e2b3d0a4889d:autoScalingGroupName/ecsworkshop-base-ECSClusterECSEC2CapacityASG0360B1DE-1P3SYY0R2VFZ0"
    managed_termination_protection = "DISABLED"

    managed_scaling {
      instance_warmup_period    = 300
      maximum_scaling_step_size = 10000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 80
    }
  }
}
