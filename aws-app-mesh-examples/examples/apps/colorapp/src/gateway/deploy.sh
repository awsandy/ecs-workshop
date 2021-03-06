#!/usr/bin/env bash
# vim:syn=sh:ts=4:sw=4:et:ai

set -ex

if [ -z $AWS_ACCOUNT_ID ]; then
    echo "AWS_ACCOUNT_ID environment variable is not set."
    exit 1
fi

if [ -z $AWS_DEFAULT_REGION ]; then
    echo "AWS_DEFAULT_REGION environment variable is not set."
    exit 1
fi
echo $AWS_DEFAULT_REGION
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

ECR_URL="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
echo "ECR URL=$ECR_URL"
COLOR_GATEWAY_IMAGE="${ECR_URL}/gateway"
echo "GWI=$COLOR_GATEWAY_IMAGE"
GO_PROXY=${GO_PROXY:-"https://proxy.golang.org"}
AWS_CLI_VERSION=$(aws --version 2>&1 | cut -d/ -f2 | cut -d. -f1)

ecr_login() {
    if [ $AWS_CLI_VERSION -gt 1 ]; then
        aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | \
            docker login --username AWS --password-stdin ${ECR_URL}
    else
        $(aws ecr get-login --no-include-email)
    fi
}

# build
docker build --build-arg GO_PROXY=$GO_PROXY -t $COLOR_GATEWAY_IMAGE ${DIR}

# push
echo "ECR URL=$ECR_URL"
echo "GWI=$COLOR_GATEWAY_IMAGE"
echo "login"
ecr_login
echo "repo"
aws ecr describe-repositories --repository-name gateway >/dev/null 2>&1 || aws ecr create-repository --repository-name gateway >/dev/null
echo "push"
docker push $COLOR_GATEWAY_IMAGE
