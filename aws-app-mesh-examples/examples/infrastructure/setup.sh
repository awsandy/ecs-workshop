export AWS_PROFILE=default
export ENVIRONMENT_NAME=mesh1
export AWS_DEFAULT_REGION=eu-west-3
export MESH_NAME=mesh1
export KEY_PAIR_NAME=andyt-mac
export SERVICES_DOMAIN=test1
export CLUSTER_SIZE=2
aws configure set region ${AWS_DEFAULT_REGION}
#export ENVOY_IMAGE=<the latest recommended envoy image, see https://docs.aws.amazon.com/app-mesh/latest/userguide/envoy.html>
export ENVOY_IMAGE="840364872350.dkr.ecr.eu-west-2.amazonaws.com/aws-appmesh-envoy:v1.16.1.1-prod"
export SERVICES_DOMAIN="default.local"
#export COLOR_GATEWAY_IMAGE=<image location for colorapp's gateway, e.g. "<youraccountnumber>.dkr.ecr.amazonaws.com/gateway:latest" - you need to build this image and use your own ECR repository, see below>
#export COLOR_TELLER_IMAGE=<image location for colorapp's teller, e.g. "<youraccountnumber>.dkr.ecr.amazonaws.com/colorteller:latest" - you need to build this image and use your own ECR repository, see below>
export COLOR_GATEWAY_IMAGE="566972129213.dkr.ecr.eu-west-2.amazonaws.com/gateway:latest"
export COLOR_TELLER_IMAGE="566972129213.dkr.ecr.eu-west-2.amazonaws.com/colorteller:latest" 

