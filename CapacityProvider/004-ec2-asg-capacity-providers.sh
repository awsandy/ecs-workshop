echo "Add EC2 ASG cap provider"
export asg_name=$(aws cloudformation describe-stacks --stack-name ecsworkshop-base --query 'Stacks[*].Outputs[?ExportName==`EC2ASGName`].OutputValue' --output text)
export asg_arn=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $asg_name --query 'AutoScalingGroups[].AutoScalingGroupARN' --output text)
export capacity_provider_name=$(echo "EC2$(date +'%s')")
# Creating capacity provider
aws ecs create-capacity-provider \
     --name $capacity_provider_name \
     --auto-scaling-group-provider autoScalingGroupArn="$asg_arn",managedScaling=\{status="ENABLED",targetCapacity=80\},managedTerminationProtection="DISABLED" \
     --region $AWS_REGION

export spot_asg_name=$(aws cloudformation describe-stacks --stack-name ecsworkshop-base --query 'Stacks[*].Outputs[?ExportName==`EC2SpotASGName`].OutputValue' --output text)
export spot_asg_arn=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $spot_asg_name --query 'AutoScalingGroups[].AutoScalingGroupARN' --output text)
export spot_capacity_provider_name=$(echo "EC2Spot$(date +'%s')")
# Creating capacity provider
aws ecs create-capacity-provider \
     --name $spot_capacity_provider_name \
     --auto-scaling-group-provider autoScalingGroupArn="$spot_asg_arn",managedScaling=\{status="ENABLED",targetCapacity=80\},managedTerminationProtection="DISABLED" \
     --region $AWS_REGION



#aws ecs put-cluster-capacity-providers --cluster container-demo \
#--capacity-providers $capacity_provider_name \
#--default-capacity-provider-strategy capacityProvider=$capacity_provider_name,weight=1,base=1

aws ecs put-cluster-capacity-providers \
--cluster container-demo \
--capacity-providers $capacity_provider_name $spot_capacity_provider_name \
--default-capacity-provider-strategy \
capacityProvider=$capacity_provider_name,weight=1,base=1 capacityProvider=$spot_capacity_provider_name,weight=4,base=0
