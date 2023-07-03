# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_vpc.vpc-0f8d08139ec381ee8:
resource "aws_vpc" "vpc-0f8d08139ec381ee8" {
  assign_generated_ipv6_cidr_block     = false
  cidr_block                           = "10.0.0.0/24"
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"
  tags = {
    "Name" = "ecsworkshop-base/BaseVPC"
  }
  tags_all = {
    "Name" = "ecsworkshop-base/BaseVPC"
  }
}
