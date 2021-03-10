##
# Empty prevos cloudstack bucket
# aws cloudformation delete-stack   --stack-name CDKToolkit
# delete stack CDKToolkit   ^^ need to empty buck first
#
#
aws cloudformation delete-stack   --stack-name CDKToolkit
aws cloudformation delete-stack   --stack-name ecsworkshop-base
aws iam get-role --role-name "AWSServiceRoleForECS" || aws iam create-service-linked-role --aws-service-name "ecs.amazonaws.com"
cd ~/environment
git clone https://github.com/brentley/container-demo
git clone https://github.com/adamjkeller/ecsdemo-capacityproviders
cd ~/environment/container-demo/cdk
cdk context --clear && cdk deploy --require-approval never
