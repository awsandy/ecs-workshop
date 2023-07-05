echo "overwite with fixed files"
cp fixed-cdk-files/platform-app.py ~/environment/ecsdemo-platform/cdk/app.py


# pip it
echo "pip requirements"

files=("ecsdemo-platform" )
for i in "${files[@]}"
do
    pip install --upgrade -r ~/environment/${i}/cdk/requirements.txt 
done

echo "cdk"

files=("ecsdemo-platform" )
for i in "${files[@]}"
do 
    echo $i
    cd ~/environment/${i}/cdk
    echo "synth"
    cdk synth
    #cdk diff
    cdk deploy --require-approval never
done
cd ~environment/ecs-workshop/mesh-microservices