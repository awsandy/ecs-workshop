##
# Empty prevos cloudstack bucket
# aws cloudformation delete-stack   --stack-name CDKToolkit
# delete stack CDKToolkit   ^^ need to empty buck first
#
#
aws cloudformation delete-stack   --stack-name CDKToolkit
aws cloudformation delete-stack   --stack-name ecsworkshop-base
aws iam get-role --role-name "AWSServiceRoleForECS" || aws iam create-service-linked-role --aws-service-name "ecs.amazonaws.com"

#git clone https://github.com/brentley/container-demo
#git clone https://github.com/adamjkeller/ecsdemo-capacityproviders

cd ~/environment/ecs-workshop/CapacityProvider/cdk-ecs-infra/cdk-asg_spot
cdk context --clear && cdk deploy --require-approval never


#ecsworkshop-base.NSName = service
#ecsworkshop-base.StressToolEc2Ip = 10.0.0.182
#ecsworkshop-base.NSId = ns-3zp7wgshw3amq42r
#ecsworkshop-base.ECSClusterName = container-demo
#ecsworkshop-base.FE2BESecGrp = sg-0ec756c01d439d4b7
#ecsworkshop-base.NSArn = arn:aws:servicediscovery:eu-west-2:566972129213:namespace/ns-3zp7wgshw3amq42r
#ecsworkshop-base.ServicesSecGrp = sg-0ec756c01d439d4b7
#ecsworkshop-base.ECSClusterSecGrp = []
#ecsworkshop-base.StressToolEc2Id = i-084b619e7c9d0ce0d