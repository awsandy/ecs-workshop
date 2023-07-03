# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_iam_role_policy.r-ecsworkshop-frontend-FrontendFargateLBServiceTaskD-ODJC573ZBWF4__FrontendFargateLBServiceTaskDefExecutionRoleDefaultPolicy7E52740C:
resource "aws_iam_role_policy" "r-ecsworkshop-frontend-FrontendFargateLBServiceTaskD-ODJC573ZBWF4__FrontendFargateLBServiceTaskDefExecutionRoleDefaultPolicy7E52740C" {
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
  role = aws_iam_role.r-ecsworkshop-frontend-FrontendFargateLBServiceTaskD-ODJC573ZBWF4.id
}
