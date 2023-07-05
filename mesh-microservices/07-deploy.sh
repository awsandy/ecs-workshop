echo "overwite with fixed files"
cp fixed-cdk-files/nodejsservice.py ~/environment/ecsdemo-nodejs/cdk/cdk/nodejsservice.py
cp fixed-cdk-files/platform-app.py ~/environment/ecsdemo-platform/cdk/app.py
cp fixed-cdk-files/crystal-app.py  ~/environment/ecsdemo-crystal/cdk/app.py
cp fixed-cdk-files/frontend-app.py ~/environment/ecsdemo-frontend/cdk/app.py

# pip it
echo "pip requirements"

files=( "ecsdemo-crystal" "ecsdemo-nodejs" "ecsdemo-frontend" "ecsdemo-platform" )
for i in "${files[@]}"
do
    pip install --upgrade -r ~/environment/${i}/cdk/requirements.txt 
done

echo "cdk"

files=( "ecsdemo-crystal" "ecsdemo-nodejs" "ecsdemo-frontend" "ecsdemo-platform" )
for i in "${files[@]}"
do 
    echo $i
    cd ~/environment/${i}/cdk
    echo "synth"
    cdk synth
    cdk diff
    cdk deploy --require-approval never
done
cd ~environment/ecs-workshop/mesh-microservices