# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_iam_role.r-ecsworkshop-nodejs-TaskDefTaskRole1EDB4A67-3W29BUBBIQ7H:
resource "aws_iam_role" "r-ecsworkshop-nodejs-TaskDefTaskRole1EDB4A67-3W29BUBBIQ7H" {
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
  name                  = "ecsworkshop-nodejs-TaskDefTaskRole1EDB4A67-3W29BUBBIQ7H"
  path                  = "/"
  tags                  = {}
  tags_all              = {}

  inline_policy {
    name = "TaskDefTaskRoleDefaultPolicyA592CB18"
    policy = jsonencode(
      {
        Statement = [
          {
            Action   = "ec2:DescribeSubnets"
            Effect   = "Allow"
            Resource = "*"
          },
        ]
        Version = "2012-10-17"
      }
    )
  }
}