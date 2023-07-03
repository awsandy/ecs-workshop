resource "aws_ssm_parameter" "vpcid" {
  name        = "/ecsworkshop/vpcid"
  description = "The vpc id"
  type        = "String"
  value       = aws_vpc.vpc-0f8d08139ec381ee8.id

  tags = {
    workshop = "ecsworkshop"
  }
}

resource "aws_ssm_parameter" "cluster" {
  name        = "/ecsworkshop/cluster"
  description = "The ecs cluster name"
  type        = "String"
  value       = aws_ecs_cluster.container-demo.name

  tags = {
    workshop = "ecsworkshop"
  }
}

resource "aws_ssm_parameter" "lbautosg" {
  name        = "/ecsworkshop/lbautosg"
  description = "Load balancer SG"
  type        = "String"
  value       = aws_security_group.sg-0a8c1a070641f7c30.id

  tags = {
    workshop = "ecsworkshop"
  }
}


resource "aws_ssm_parameter" "lbsg" {
  name        = "/ecsworkshop/lbsg"
  description = "Load balancer SG"
  type        = "String"
  value       = aws_security_group.sg-0336ba9305f717ce8.id

  tags = {
    workshop = "ecsworkshop"
  }
}


resource "aws_ssm_parameter" "privatesubnet1" {
  name        = "/ecsworkshop/PrivateSubnet1"
  description = "The ecs private subnet 1"
  type        = "String"
  value       = aws_subnet.subnet-002db849c8babcf4b.id

  tags = {
    workshop = "ecsworkshop"
  }
}


resource "aws_ssm_parameter" "privatesubnet2" {
  name        = "/ecsworkshop/PrivateSubnet2"
  description = "The ecs private subnet 2"
  type        = "String"
  value       = aws_subnet.subnet-061a3e11c868dec09.id

  tags = {
    workshop = "ecsworkshop"
  }
}

resource "aws_ssm_parameter" "privatesubnet3" {
  name        = "/ecsworkshop/PrivateSubnet3"
  description = "The ecs private subnet 3"
  type        = "String"
  value       = aws_subnet.subnet-0c00f06ac09e279ac.id

  tags = {
    workshop = "ecsworkshop"
  }
}

resource "aws_ssm_parameter" "publicsubnet1" {
  name        = "/ecsworkshop/PublicSubnet1"
  description = "The ecs public subnet 1"
  type        = "String"
  value       = aws_subnet.subnet-0cb7f045d1e65a317.id

  tags = {
    workshop = "ecsworkshop"
  }
}

resource "aws_ssm_parameter" "publicsubnet2" {
  name        = "/ecsworkshop/PublicSubnet2"
  description = "The ecs public subnet 2"
  type        = "String"
  value       = aws_subnet.subnet-0b577247c767ac4c5.id

  tags = {
    workshop = "ecsworkshop"
  }
}

resource "aws_ssm_parameter" "publicsubnet3" {
  name        = "/ecsworkshop/PublicSubnet3"
  description = "The ecs public subnet 3"
  type        = "String"
  value       = aws_subnet.subnet-07b8d4e34ea1baed5.id

  tags = {
    workshop = "ecsworkshop"
  }
}