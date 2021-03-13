cd ~/environment/ecs-workshop/CapacityProvider/ecsdemo-capacityproviders/fargate
cdk destroy -f
cd ~/environment/ecs-workshop/CapacityProvider/demoapp-capacityproviders/ec2-spot
cdk destroy -f
cd ~/environment/ecs-workshop/CapacityProvider/cdk-ecs-infra/cdk-asg_spot
cdk destroy -f
