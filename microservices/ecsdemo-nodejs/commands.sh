#!/bin/bash
echo 'Stack ecsworkshop-nodejs Importing 0 of 10 ..'
echo 'Stack ecsworkshop-nodejs Importing 1 of 10 ..'
../../scripts/get-ecs-service.sh arn:aws:ecs:eu-west-2:566972129213:service/container-demo/ecsdemo-nodejs
echo 'Stack ecsworkshop-nodejs Importing 2 of 10 ..'
../../scripts/get-sd-service.sh srv-hzimv2g2c4s3g2hv
echo 'Stack ecsworkshop-nodejs Importing 3 of 10 ..'
echo '# AWS::ApplicationAutoScaling::ScalableTarget container-demo fetched as part of parent recources ' 
echo 'Stack ecsworkshop-nodejs Importing 4 of 10 ..'
echo '# AWS::ApplicationAutoScaling::ScalingPolicy ecs fetched as part of parent recources ' 
echo 'Stack ecsworkshop-nodejs Importing 5 of 10 ..'
../../scripts/get-ecs-task.sh ecsworkshopnodejsTaskDef2754560E:1
echo 'Stack ecsworkshop-nodejs Importing 6 of 10 ..'
../../scripts/050-get-iam-roles.sh ecsworkshop-nodejs-TaskDefExecutionRoleB4775C97-MKZMEQBVX71H
echo 'Stack ecsworkshop-nodejs Importing 7 of 10 ..'
# AWS::IAM::Policy ecswo-Task-17MOYZ6V5GJVF Should be fetched via Roles etc
echo 'Stack ecsworkshop-nodejs Importing 8 of 10 ..'
../../scripts/050-get-iam-roles.sh ecsworkshop-nodejs-TaskDefTaskRole1EDB4A67-3W29BUBBIQ7H
echo 'Stack ecsworkshop-nodejs Importing 9 of 10 ..'
# AWS::IAM::Policy ecswo-Task-1CNU7XLSMK50H Should be fetched via Roles etc
echo 'Stack ecsworkshop-nodejs Importing 10 of 10 ..'
../../scripts/070-get-cw-log-grp.sh /ecsworkshop-nodejs-ecsworkshopNodejsF670245F-jnKh4tbV32Iu
echo "Commands Done .."
