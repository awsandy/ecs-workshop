## Fargate Capacity Provider

* added to cluser with cli : 
```bash 
aws aws ecs put-cluster-capacity-providers --cluster container-demo \
--capacity-providers FARGATE FARGATE_SPOT --default-capacity-provider-strategy \
capacityProvider=FARGATE,weight=1,base=1 capacityProvider=FARGATE_SPOT,weight=4
```

* base - what to run on at least one capacity provider
* weight here say for ever 1 task on Fargate 4 tasks wil be on Fargate_spot
* app runs returns task arn and if Fargate or fargate_spot  in ecsdemo-capacityproviders/fargate

App itself is created by CDK:

class CapacityProviderFargateService(core.Stack):
    
    def __init__(self, scope: core.Stack, id: str, **kwargs):
        super().__init__(scope, id, **kwargs)

        self.base_platform = BasePlatform(self, self.stack_name)

        self.task_image = aws_ecs_patterns.ApplicationLoadBalancedTaskImageOptions(
            image=aws_ecs.ContainerImage.from_registry("*adam9098/ecsdemo-capacityproviders:latest*"),
            container_port=5000,
        )

        self.load_balanced_service = aws_ecs_patterns.ApplicationLoadBalancedFargateService(
            self, "FargateCapacityProviderService",
            service_name='ecsdemo-capacityproviders-fargate',
            cluster=self.base_platform.ecs_cluster,
            cpu=256,
            memory_limit_mib=512,
            desired_count=10,
            public_load_balancer=True,
            task_image_options=self.task_image,
            platform_version=aws_ecs.FargatePlatformVersion.VERSION1_4
        )


## EC2 Capacity provider

In container-demo/cdk

CDK deploys the cluste rinfra including the capacity provider CDK code (can't be doen form cli):

Capacity provider must be created via an API - eg CDK

self.asg = self.ecs_cluster.add_capacity("ECSEC2Capacity",
    instance_type=aws_ec2.InstanceType(instance_type_identifier='t3.small'),
    min_capacity=0, max_capacity=10)
        
core.CfnOutput(self, "EC2AutoScalingGroupName", value=self.asg auto_scaling_group_name, export_name="EC2ASGName")

---

Setup capacity provider in ECS - use CLI now CDK has created it !

export asg_name=$(aws cloudformation describe-stacks --stack-name ecsworkshop-base --query 'Stacks[*].Outputs[?ExportName==`EC2ASGName`].OutputValue' --output text)
export asg_arn=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $asg_name --query 'AutoScalingGroups[].AutoScalingGroupARN' --output text)
export capacity_provider_name=$(echo "EC2$(date +'%s')")
# Creating capacity provider
aws ecs create-capacity-provider \
     --name $capacity_provider_name \
     --auto-scaling-group-provider autoScalingGroupArn="$asg_arn",managedScaling=\{status="ENABLED",targetCapacity=80\},managedTerminationProtection="DISABLED" \
     --region $AWS_REGION

aws ecs put-cluster-capacity-providers \
--cluster container-demo \
--capacity-providers $capacity_provider_name \
--default-capacity-provider-strategy capacityProvider=$capacity_provider_name,weight=1,base=1



---

Then a sample app EC2 backed ECS service from  ecsdemo-capacityproviders/ec2



## EC2 SPOT Capacity provider


* Notice we are creating a Launch Template. This is required to combine instance types and purchase options on an Auto Scaling group.
* On the User Data of the launch template, we’re configuring the ECS agent to drain a Spot Container Instance when receiving an interruption notice: ECS_ENABLE_SPOT_INSTANCE_DRAINING=true.
* On the Auto Scaling group, we’re defining a Mixed Instances Policy. On instance distribution, we’re setting up the Auto Scaling group to launch only EC2 Spot Instances and use the capacity-optimized Spot Allocation Strategy. This makes Auto Scaling launch instances from the Spot capacity pool with optimal capacity for the number or instances that are launching. Deploying this way helps you make the most efficient use of spare EC2 capacity and reduce the likelihood of interruptions.
* On the overrides section, we’re configuring 10 different instance types that we can use on our ECS cluster. Multipliying this number by the number of Availability Zones in use will give us the number of Spot capacity pools we can launch capacity from ( e.g. if we’re across 3 AZs, it means we can get capacity from 30 different Spot capacity pools). This maximizes our ability provision and maintain the required Spot capacity (the more pools the better).
* Note this time we’re using larger instance types than with On-Demand (*.large vs. t3.small). The reason the instances are larger is to be able to select a higher number of instance types to be flexible across (smaller sizes are only available on t* instance types and old generation instances like m3. m4 and m5 instances smallest type is large). It’s recommended that you combine instances of the same size when creating an Auto Scaling group for ECS for predictable scaling behavior.







## Terraform

https://github.com/hashicorp/terraform-provider-aws/pull/16942
