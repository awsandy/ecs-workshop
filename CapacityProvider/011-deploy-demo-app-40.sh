echo "Deploy app with 1x task"
cd ~/environment/ecs-workshop/CapacityProvider/demoapp-capacityproviders/ec2-spot
cp app.py.40 app.py
cdk context --clear && cdk deploy --require-approval never