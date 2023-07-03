# Install prerequisite packages
sudo yum -y install jq nodejs siege

# Install cdk packages
pip3 install --user --upgrade awslogs

#  Verify environment variables required to communicate with AWS API's via the cli tools
grep AWS_DEFAULT_REGION ~/.bashrc 
if [ $? -ne 0 ]; then
    echo "export AWS_DEFAULT_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)" >> ~/.bashrc
fi

grep AWS_REGION ~/.bashrc 
if [ $? -ne 0 ]; then
    echo "export AWS_REGION=\$AWS_DEFAULT_REGION" >> ~/.bashrc
fi

grep AWS_ACCOUNT_ID ~/.bashrc 
if [ $? -ne 0 ]; then
    echo "export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)" >> ~/.bashrc
fi 

source ~/.bashrc
cd ~/environment
git clone https://github.com/aws-containers/ecsdemo-platform
git clone https://github.com/aws-containers/ecsdemo-frontend
git clone https://github.com/aws-containers/ecsdemo-nodejs
git clone https://github.com/aws-containers/ecsdemo-crystal
aws iam get-role --role-name "AWSServiceRoleForElasticLoadBalancing" || aws iam create-service-linked-role --aws-service-name "elasticloadbalancing.amazonaws.com"

aws iam get-role --role-name "AWSServiceRoleForECS" || aws iam create-service-linked-role --aws-service-name "ecs.amazonaws.com"

curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm"
sudo yum install -y session-manager-plugin.rpm
session-manager-plugin
