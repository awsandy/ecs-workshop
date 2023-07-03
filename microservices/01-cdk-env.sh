cd ~/environment/ecsdemo-platform/cdk
pip install -r requirements.txt --user
cdk bootstrap aws://$AWS_ACCOUNT_ID/$AWS_DEFAULT_REGION
cdk synth
#cdf diff
cdk deploy --require-approval never
# frontend
cd ~/environment/ecsdemo-frontend/cdk
pip install -r requirements.txt --user
cdk synth
cdk deploy --require-approval never
# node backend
cd ~/environment/ecsdemo-nodejs/cdk
pip install -r requirements.txt --user
cdk synth
cdk deploy --require-approval never
# crystal backend
cd ~/environment/ecsdemo-crystal/cdk
pip install -r requirements.txt --user
cdk synth
cdk deploy --require-approval never






