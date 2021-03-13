echo " do fargate and fargate spot provider with cli"
aws ecs put-cluster-capacity-providers \
--cluster container-demo \
--capacity-providers FARGATE FARGATE_SPOT \
--default-capacity-provider-strategy \
capacityProvider=FARGATE,weight=1,base=1 \
capacityProvider=FARGATE_SPOT,weight=4
echo "- start sample app"
cd ecsdemo-capacityproviders/fargate
cdk diff



