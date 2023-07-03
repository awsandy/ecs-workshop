alb_url=$(aws cloudformation describe-stacks --stack-name ecsworkshop-frontend --query "Stacks" --output json | jq -r '.[].Outputs[] | select(.OutputKey |contains("LoadBalancer")) | .OutputValue')
siege -c 20 -i $alb_url 
#
while true; do sleep 3; aws ecs describe-services --cluster container-demo --services ecsdemo-frontend | jq '.services[] | "Tasks Desired: \(.desiredCount) vs Tasks Running: \(.runningCount)"'; done


ec2InstanceId=$(aws cloudformation describe-stacks --stack-name ecsworkshop-base --query "Stacks" --output json | jq -r '.[].Outputs[] | select(.OutputKey |contains("StressToolEc2Id")) | .OutputValue')
aws ssm start-session --target "$ec2InstanceId"
siege -c 100 -i http://ecsdemo-nodejs.service.local:3000



ec2InstanceId=$(aws cloudformation describe-stacks --stack-name ecsworkshop-base --query "Stacks" --output json | jq -r '.[].Outputs[] | select(.OutputKey |contains("StressToolEc2Id")) | .OutputValue')
aws ssm start-session --target "$ec2InstanceId"
siege -c 200 -i http://ecsdemo-crystal.service.local:3000/crystal