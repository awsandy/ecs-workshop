# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_iam_role_policy.r-ecsworkshop-nodejs-TaskDefTaskRole1EDB4A67-3W29BUBBIQ7H__TaskDefTaskRoleDefaultPolicyA592CB18:
resource "aws_iam_role_policy" "r-ecsworkshop-nodejs-TaskDefTaskRole1EDB4A67-3W29BUBBIQ7H__TaskDefTaskRoleDefaultPolicyA592CB18" {
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
  role = aws_iam_role.r-ecsworkshop-nodejs-TaskDefTaskRole1EDB4A67-3W29BUBBIQ7H.id
}
