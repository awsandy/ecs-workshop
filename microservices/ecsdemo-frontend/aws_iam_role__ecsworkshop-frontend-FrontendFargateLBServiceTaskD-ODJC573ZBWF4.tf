# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_iam_role.r-ecsworkshop-frontend-FrontendFargateLBServiceTaskD-ODJC573ZBWF4:
resource "aws_iam_role" "r-ecsworkshop-frontend-FrontendFargateLBServiceTaskD-ODJC573ZBWF4" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "ecs-tasks.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  force_detach_policies = false
  managed_policy_arns   = []
  max_session_duration  = 3600
  name                  = "ecsworkshop-frontend-FrontendFargateLBServiceTaskD-ODJC573ZBWF4"
  path                  = "/"
  tags                  = {}
  tags_all              = {}

  inline_policy {
    name = "FrontendFargateLBServiceTaskDefExecutionRoleDefaultPolicy7E52740C"
    policy = jsonencode(
      {
        Statement = [
          {
            Action = [
              "logs:CreateLogStream",
              "logs:PutLogEvents",
            ]
            Effect   = "Allow"
            Resource = format("arn:aws:logs:%s:%s:log-group:ecsworkshop-frontend-FrontendFargateLBServiceTaskDefwebLogGroup3132F919-8PPYoyUGSUb3:*", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
          },
        ]
        Version = "2012-10-17"
      }
    )
  }
}