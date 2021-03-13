echo "Deploy app with 400x tasks"
cd ~/environment/ecs-workshop/CapacityProvider/demoapp-capacityproviders/ec2-spot
cp app.py.200 app.py
cdk context --clear && cdk deploy --require-approval never