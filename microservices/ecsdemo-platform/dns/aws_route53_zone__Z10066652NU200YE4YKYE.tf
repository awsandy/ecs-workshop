# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_route53_zone.Z10066652NU200YE4YKYE:
resource "aws_route53_zone" "Z10066652NU200YE4YKYE" {
  comment = "Created by AWS Cloud Map namespace with ARN arn:aws:servicediscovery:eu-west-2:566972129213:namespace/ns-edlae6eydoee5gbk"
  name    = "service.local"

  tags     = {}
  tags_all = {}

  vpc {
    vpc_id     = aws_vpc.vpc-0f8d08139ec381ee8.id
    vpc_region = "eu-west-2"
  }
}
