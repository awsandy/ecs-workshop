# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_internet_gateway.igw-0a5d2e7e001359717:
resource "aws_internet_gateway" "igw-0a5d2e7e001359717" {
  tags = {
    "Name" = "ecsworkshop-base/BaseVPC"
  }
  tags_all = {
    "Name" = "ecsworkshop-base/BaseVPC"
  }
  vpc_id = aws_vpc.vpc-0f8d08139ec381ee8.id
}
