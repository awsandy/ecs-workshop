aws cloudformation delete-stack --stack-name "${ENVIRONMENT_NAME}-appmesh-mesh"
aws cloudformation delete-stack --stack-name "${ENVIRONMENT_NAME}-ecs-cluster"
aws cloudformation delete-stack --stack-name "${ENVIRONMENT_NAME}-vpc"