# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_nat_gateway.nat-0826d5e78c18c1fb0:
resource "aws_nat_gateway" "nat-0826d5e78c18c1fb0" {
  allocation_id     = aws_eip.eipalloc-0f25141a243a57bda.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.subnet-0cb7f045d1e65a317.id
  tags = {
    "Name" = "ecsworkshop-base/BaseVPC/PublicSubnet1"
  }
  tags_all = {
    "Name" = "ecsworkshop-base/BaseVPC/PublicSubnet1"
  }
}
