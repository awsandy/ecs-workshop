# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_eip.eipalloc-0f25141a243a57bda:
resource "aws_eip" "eipalloc-0f25141a243a57bda" {
  network_border_group = "eu-west-2"
  public_ipv4_pool     = "amazon"
  tags = {
    "Name" = "ecsworkshop-base/BaseVPC/PublicSubnet1"
  }
  tags_all = {
    "Name" = "ecsworkshop-base/BaseVPC/PublicSubnet1"
  }
  vpc = true
}
