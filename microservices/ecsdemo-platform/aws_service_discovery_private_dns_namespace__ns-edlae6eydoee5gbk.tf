# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_service_discovery_private_dns_namespace.ns-edlae6eydoee5gbk:
resource "aws_service_discovery_private_dns_namespace" "ns-edlae6eydoee5gbk" {
  name     = "service.local"
  tags     = {}
  tags_all = {}
  vpc      = aws_vpc.vpc-0f8d08139ec381ee8.id
}