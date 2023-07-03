data "aws_security_group" "sg-0d14e44c94b32a349" {
  name   = "default"
  vpc_id = aws_vpc.vpc-0f8d08139ec381ee8.id
}
