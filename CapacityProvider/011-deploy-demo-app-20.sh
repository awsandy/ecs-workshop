echo "Deploy app with 20x tasks"
cd ~/environment/ecs-workshop/CapacityProvider/demoapp-capacityproviders/ec2-spot
cp app.py.20 app.py
cdk context --clear && cdk deploy --require-approval never
date