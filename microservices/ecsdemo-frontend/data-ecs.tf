data "aws_ecs_cluster" "cluster" {
  cluster_name = data.aws_ssm_parameter.cluster.value
}