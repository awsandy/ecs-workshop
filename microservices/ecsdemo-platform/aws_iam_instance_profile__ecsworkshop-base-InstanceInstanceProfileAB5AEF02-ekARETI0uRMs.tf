# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_iam_instance_profile.ecsworkshop-base-InstanceInstanceProfileAB5AEF02-ekARETI0uRMs:
resource "aws_iam_instance_profile" "ecsworkshop-base-InstanceInstanceProfileAB5AEF02-ekARETI0uRMs" {
  name     = "ecsworkshop-base-InstanceInstanceProfileAB5AEF02-ekARETI0uRMs"
  path     = "/"
  role     = aws_iam_role.r-ecsworkshop-base-InstanceSSMCBFA3CF0-BKXGZVPPRO9K.name
  tags     = {}
  tags_all = {}
}
