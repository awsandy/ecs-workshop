# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_ecs_service.container-demo__ecsdemo-nodejs:
resource "aws_ecs_service" "container-demo__ecsdemo-nodejs" {
  cluster                            = data.aws_ssm_parameter.cluster.arn
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50
  desired_count                      = 3
  enable_ecs_managed_tags            = false
  enable_execute_command             = false
  health_check_grace_period_seconds  = 0
  #iam_role                           = "/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  launch_type                        = "FARGATE"
  name                               = "ecsdemo-nodejs"
  platform_version                   = "LATEST"
  scheduling_strategy                = "REPLICA"
  tags                               = {}
  tags_all                           = {}
  task_definition                    = aws_ecs_task_definition.ecsworkshopnodejsTaskDef2754560E_1.arn
  triggers                           = {}

  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }

  deployment_controller {
    type = "ECS"
  }


    network_configuration {
    assign_public_ip = false
    security_groups = [
      data.aws_ssm_parameter.lbsg.value,
    ]
    subnets = [
      data.aws_ssm_parameter.privatesubnet1.value,
      data.aws_ssm_parameter.privatesubnet2.value,
      data.aws_ssm_parameter.privatesubnet3.value,
    ]
  }

  service_registries {
    container_port = 0
    port           = 0
    registry_arn   = "arn:aws:servicediscovery:eu-west-2:566972129213:service/srv-drywcrjoa2ul3ybn"
  }
}
