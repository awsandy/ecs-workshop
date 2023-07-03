data "aws_ssm_parameter" "vpcid" {
  name        = "/ecsworkshop/vpcid"
}

data "aws_ssm_parameter" "cluster" {
  name        = "/ecsworkshop/cluster"
}

data "aws_ssm_parameter" "lbsg" {
  name        = "/ecsworkshop/lbsg"
}

data "aws_ssm_parameter" "privatesubnet1" {
  name        = "/ecsworkshop/PrivateSubnet1"
}

data "aws_ssm_parameter" "privatesubnet2" {
  name        = "/ecsworkshop/PrivateSubnet2"
}

data "aws_ssm_parameter" "privatesubnet3" {
  name        = "/ecsworkshop/PrivateSubnet3"
}


data "aws_ssm_parameter" "publicsubnet1" {
  name        = "/ecsworkshop/PublicSubnet1"
}

data "aws_ssm_parameter" "publicsubnet2" {
  name        = "/ecsworkshop/PublicSubnet2"
}

data "aws_ssm_parameter" "publicsubnet3" {
  name        = "/ecsworkshop/PublicSubnet3"
}

data "aws_ssm_parameter" "lbautosg" {
  name        = "/ecsworkshop/lbautosg"
}