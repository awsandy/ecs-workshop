cd ~/environment/ecsdemo-frontend/cdk
cdk destroy -f
cd ~/environment/ecsdemo-nodejs/cdk
cdk destroy -f
cd ~/environment/ecsdemo-crystal/cdk
cdk destroy -f
cd ~/environment/ecsdemo-platform/cdk
cdk destroy -f
python -c "import boto3
c = boto3.client('logs')
services = ['ecsworkshop-mesh-gateway' 'ecsworkshop-frontend', 'ecsworkshop-nodejs', 'ecsworkshop-crystal', 'ecsworkshop-capacityproviders-fargate', 'ecsworkshop-capacityproviders-ec2', 'ecsworkshop-efs-fargate-demo']
for service in services:
    frontend_logs = c.describe_log_groups(logGroupNamePrefix=service)
    print([c.delete_log_group(logGroupName=x['logGroupName']) for x in frontend_logs['logGroups']])"
cd ~/environment/ecs-workshop/mesh-microservices