# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_security_group.sg-0a8c1a070641f7c30:
resource "aws_security_group" "sg-0a8c1a070641f7c30" {
  description = "Automatically created Security Group for ELB ecsworkshopfrontendFrontendFargateLBServiceLBD83D49CC"
  tags        = {}
  tags_all    = {}
  vpc_id      = aws_vpc.vpc-0f8d08139ec381ee8.id
}
