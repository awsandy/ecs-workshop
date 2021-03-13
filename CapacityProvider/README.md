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

---
---

## EC2 Capacity provider - autoscaling

In container-demo/cdk  9renamed cdk-ecs-inrastructure/cdk-asg

CDK deploys the cluster infra including the capacity provider CDK code (can't be doen form cli):

Capacity provider must be created via an API - eg CDK

self.asg = self.ecs_cluster.add_capacity("ECSEC2Capacity",
    instance_type=aws_ec2.InstanceType(instance_type_identifier='t3.small'),
    min_capacity=0, max_capacity=10)
        
core.CfnOutput(self, "EC2AutoScalingGroupName", value=self.asg.auto_scaling_group_name, export_name="EC2ASGName")

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

aws ecs put-cluster-capacity-providers --cluster container-demo \
--capacity-providers $capacity_provider_name \
--default-capacity-provider-strategy capacityProvider=$capacity_provider_name,weight=1,base=1



---

Then a sample app EC2 backed ECS service from  ecsdemo-capacityproviders/ec2 (renamed )

* starts with 2x EC2 instances
* edit ecsdemo-capacityproviders/ec2/app.py - change desired count to 10 (from 1) 
* initially taks will show soem `provisionig`
* instances still shows 2x EC2 and also 4 pending tasks
* several minutes later 10 running taks and 4x EC2 instances as CW alarm triggers EC2 scaling
----
* edit ecsdemo-capacityproviders/ec2/app.py - change desired count back to 1 




## EC2 SPOT Capacity provider


* Notice we are creating a Launch Template. required to combine instance types and purchase options on an ASG
* On the User Data of the launch template, we’re configuring the ECS agent to drain a Spot Container Instance when receiving an interruption notice: ECS_ENABLE_SPOT_INSTANCE_DRAINING=true.
* On the Auto Scaling group, we’re defining a Mixed Instances Policy. On instance distribution, we’re setting up the Auto Scaling group to launch only EC2 Spot Instances and use the capacity-optimized Spot Allocation Strategy. This makes Auto Scaling launch instances from the Spot capacity pool with optimal capacity for the number or instances that are launching. Deploying this way helps you make the most efficient use of spare EC2 capacity and reduce the likelihood of interruptions.
* On the overrides section, we’re configuring 10 different instance types that we can use on our ECS cluster. Multipliying this number by the number of Availability Zones in use will give us the number of Spot capacity pools we can launch capacity from 
* larger instance types than with On-Demand (*.large vs. t3.small).  be able to select a higher number of instance types to be flexible 

```
###### EC2 SPOT CAPACITY PROVIDER SECTION ######
        
        ## As of today, AWS CDK doesn't support Launch Templates on the AutoScaling construct, hence it
        ## doesn't support Mixed Instances Policy to combine instance types on Auto Scaling and adhere to Spot best practices
        ## In the meantime, CfnLaunchTemplate and CfnAutoScalingGroup resources are used to configure Spot capacity
        ## https://github.com/aws/aws-cdk/issues/6734
        
        self.ecs_spot_instance_role = aws_iam.Role(
            self, "ECSSpotECSInstanceRole",
            assumed_by=aws_iam.ServicePrincipal("ec2.amazonaws.com"),
            managed_policies=[
                aws_iam.ManagedPolicy.from_aws_managed_policy_name("service-role/AmazonEC2ContainerServiceforEC2Role"),
                aws_iam.ManagedPolicy.from_aws_managed_policy_name("service-role/AmazonEC2RoleforSSM")
                ]
        )
        
        self.ecs_spot_instance_profile = aws_iam.CfnInstanceProfile(
            self, "ECSSpotInstanceProfile",
            roles = [
                    self.ecs_spot_instance_role.role_name
                ]
            )
        
        ## This creates a Launch Template for the Auto Scaling group
        self.lt = aws_ec2.CfnLaunchTemplate(
            self, "ECSEC2SpotCapacityLaunchTemplate",
            launch_template_data={
                "instanceType": "m5.large",
                "imageId": aws_ssm.StringParameter.value_for_string_parameter(
                            self,
                            "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"),
                "securityGroupIds": [ x.security_group_id for x in self.ecs_cluster.connections.security_groups ],
                "iamInstanceProfile": {"arn": self.ecs_spot_instance_profile.attr_arn},
        #        
        ## Here we configure the ECS agent to drain Spot Instances upon catching a Spot Interruption notice from instance metadata
                "userData": core.Fn.base64(
                    core.Fn.sub(
                        "#!/usr/bin/bash\n"
                        "echo ECS_CLUSTER=${cluster_name} >> /etc/ecs/ecs.config\n" 
                        "sudo iptables --insert FORWARD 1 --in-interface docker+ --destination 169.254.169.254/32 --jump DROP\n"
                        "sudo service iptables save\n"
                        "echo ECS_ENABLE_SPOT_INSTANCE_DRAINING=true >> /etc/ecs/ecs.config\n" 
                        "echo ECS_AWSVPC_BLOCK_IMDS=true >> /etc/ecs/ecs.config\n"  
                        "cat /etc/ecs/ecs.config",
                        variables = {
                            "cluster_name":self.ecs_cluster.cluster_name
                            }
                        )
                    )
                },
                launch_template_name="ECSEC2SpotCapacityLaunchTemplate")
                
        self.ecs_ec2_spot_mig_asg = aws_autoscaling.CfnAutoScalingGroup(
            self, "ECSEC2SpotCapacity",
            min_size = "0",
            max_size = "10",
            vpc_zone_identifier = [ x.subnet_id for x in self.vpc.private_subnets ],
            mixed_instances_policy = {
                "instancesDistribution": {
                    "onDemandAllocationStrategy": "prioritized",
                    "onDemandBaseCapacity": 0,
                    "onDemandPercentageAboveBaseCapacity": 0,
                    "spotAllocationStrategy": "capacity-optimized"
                    },
                "launchTemplate": {
                    "launchTemplateSpecification": {
                        "launchTemplateId": self.lt.ref,
                        "version": self.lt.attr_default_version_number
                    },
                    "overrides": [
                        {"instanceType": "m5.large"},
                        {"instanceType": "m5d.large"},
                        {"instanceType": "m5a.large"},
                        {"instanceType": "m5ad.large"},
                        {"instanceType": "m5n.large"},
                        {"instanceType": "m5dn.large"},
                        {"instanceType": "m3.large"},
                        {"instanceType": "m4.large"},
                        {"instanceType": "t3.large"},
                        {"instanceType": "t2.large"}
                    ]
                }
            }
        )
        #
        core.Tag.add(self.ecs_ec2_spot_mig_asg, "Name", self.ecs_ec2_spot_mig_asg.node.path) 
        core.CfnOutput(self, "EC2SpotAutoScalingGroupName", value=self.ecs_ec2_spot_mig_asg.ref, export_name="EC2SpotASGName")       
        #
        ##### END EC2 SPOT CAPACITY PROVIDER SECTION #####
```

## Create cluster capacity provider

# Get the required cluster values needed when creating the capacity provider
export spot_asg_name=$(aws cloudformation describe-stacks --stack-name ecsworkshop-base --query 'Stacks[*].Outputs[?ExportName==`EC2SpotASGName`].OutputValue' --output text)
export spot_asg_arn=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $spot_asg_name --query 'AutoScalingGroups[].AutoScalingGroupARN' --output text)
export spot_capacity_provider_name=$(echo "EC2Spot$(date +'%s')")
# Creating capacity provider
aws ecs create-capacity-provider \
     --name $spot_capacity_provider_name \
     --auto-scaling-group-provider autoScalingGroupArn="$spot_asg_arn",managedScaling=\{status="ENABLED",targetCapacity=80\},managedTerminationProtection="DISABLED" \
     --region $AWS_REGION


## Add capacity provider
```bash
aws ecs put-cluster-capacity-providers \
--cluster container-demo \
--capacity-providers $capacity_provider_name $spot_capacity_provider_name \
--default-capacity-provider-strategy capacityProvider=$capacity_provider_name,weight=1,base=1 capacityProvider=$spot_capacity_provider_name,weight=4,base=0
```

----

* See 4 instances - 2 ondemand 2 spot

```bash
aws ecs describe-container-instances --cluster container-demo  \
    --container-instances $(aws ecs list-container-instances --cluster container-demo \
                --query 'containerInstanceArns[]' --output text) \
    --query 'containerInstances[].{InstanceId: ec2InstanceId, 
                CapacityProvider: capacityProviderName, RunningTasks: runningTasksCount}' \
                --output table
```

Must update running service to use new capacity provider:

Find service - `update`  find EC2Spot Provider - weight 4 - Force New Deployment

Monitor redeployment in `Deployments` tab


* edit ecsdemo-capacityproviders/ec2/app.py - set desired to 40 (larger instances so need to scale more)

```
aws ecs describe-tasks --cluster container-demo --tasks \
    $(aws ecs list-tasks --cluster container-demo --query 'taskArns[]' --output text) \
        --query 'sort_by(tasks,&capacityProviderName)[].{ 
            Id: taskArn, AZ: availabilityZone, CapacityProvider: capacityProviderName, 
                    LastStatus: lastStatus, DesiredStatus: desiredStatus}' --output table
```

```
aws ecs describe-container-instances --cluster container-demo 
    --container-instances $(aws ecs list-container-instances \
        --cluster container-demo --query 'containerInstanceArns[]' --output text) \
                --query 'containerInstances[].{InstanceId: ec2InstanceId, 
                    CapacityProvider: capacityProviderName, RunningTasks: runningTasksCount}' \
                --output table
```


### SPOT Interruptions

Simulating: 

I’ve managed to simulate this once:
I’ve used non-common instance for my ASG and choose it according to https://aws.amazon.com/ec2/spot/instance-advisor/ to have high frequency of interruption - m2.xlarge at us-east-1 for example
Then, I’ve launched another ASG (configured to be On demand) and simply start manually scaling it until I’ve got the interruption on the first ASG that was configured with Spot). Not the “cleanest” test, but it worked


 if the ECS_ENABLE_SPOT_INSTANCE_DRAINING flag is set . Then ECS will stop scheduling further jobs on the instance that has been marked for spot termination.

 Hi Srijit,  there is no automatic fall back from FARGATE_SPOT to FARGATE. The weights configured in the Capacity Provider configuration are hard weights. ECS will wait until there is FARGATE_SPOT capacity to continue provisioning the task. So, if your customer needs immediate guaranteed resource availability, we recommend using FARGATE, not FARGATE_SPOT.




## Terraform

https://github.com/hashicorp/terraform-provider-aws/pull/16942


----

scale 200 tasks - seem to get even distro of tasks spot / on-deamnd - 20 insyance (10 each)

scale down to 20 - 1 task on each of 20 nodes  
(3840 cpu units avail per node - +254 1 running task = 4096)

wait 5 minutes (cooldown)

The target capacity - if total cluster > 80% scale up

Doesn't work as expected - is ECS service you have deined using these cpacity providers (two of them )

Also need to remove tasks properly (let CF run) - other wide may leave capacity allocated in cluster

(follow alarm in CW)
