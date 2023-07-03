# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_iam_role_policy.r-ecsworkshop-nodejs-TaskDefExecutionRoleB4775C97-MKZMEQBVX71H__TaskDefExecutionRoleDefaultPolicy0DBB737A:
resource "aws_iam_role_policy" "r-ecsworkshop-nodejs-TaskDefExecutionRoleB4775C97-MKZMEQBVX71H__TaskDefExecutionRoleDefaultPolicy0DBB737A" {
  name = "TaskDefExecutionRoleDefaultPolicy0DBB737A"
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
          ]
          Effect   = "Allow"
          Resource = format("arn:aws:logs:%s:%s:log-group:ecsworkshop-nodejs-ecsworkshopNodejsF670245F-jnKh4tbV32Iu:*", data.aws_region.current.name, data.aws_caller_identity.current.account_id)
        },
      ]
      Version = "2012-10-17"
    }
  )
  role = aws_iam_role.r-ecsworkshop-nodejs-TaskDefExecutionRoleB4775C97-MKZMEQBVX71H.id
}
