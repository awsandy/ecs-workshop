# platform

echo "Mesh edits"

# platform
cd ~/environment/ecsdemo-platform/cdk
sed -i -e '/self.appmesh()/s/# //' ~/environment/ecsdemo-platform/cdk/app.py

## Crystal

lines=($(grep -Fn '#appmesh-proxy-uncomment' ~/environment/ecsdemo-crystal/cdk/app.py | cut -f1 -d:))
unstart=$((${lines[0]} + 1))
unend=$((${lines[1]} - 1))
sed -i "${unstart},${unend} s/# //" ~/environment/ecsdemo-crystal/cdk/app.py 
sed -i -e "/self.appmesh()/s/# //" ~/environment/ecsdemo-crystal/cdk/app.py


# nodejs
lines=($(grep -Fn '#appmesh-proxy-uncomment' ~/environment/ecsdemo-nodejs/cdk/app.py | cut -f1 -d:))
unstart=$((${lines[0]} + 1))
unend=$((${lines[1]} - 1))
sed -i "${unstart},${unend} s/# //" ~/environment/ecsdemo-nodejs/cdk/app.py 
sed -i -e '/self.appmesh()/s/# //' ~/environment/ecsdemo-nodejs/cdk/app.py

# frontend
#Commenting previous class
sed -i -e '/FrontendService(app, stack_name, env=_env)/s/^#*/#/' ~/environment/ecsdemo-frontend/cdk/app.py 
#Uncommenting new class
sed -i -e "/FrontendServiceMesh(app, stack_name, env=_env)/s/# //" ~/environment/ecsdemo-frontend/cdk/app.py 


echo "XRay edits"

files=( "ecsdemo-crystal" "ecsdemo-nodejs" "ecsdemo-frontend" "ecsdemo-platform" )
for i in "${files[@]}"
do 
    sed -i -e '/ENABLE_ENVOY_XRAY_TRACING/s/# //' ~/environment/${i}/cdk/app.py
done

files=( "ecsdemo-crystal" "ecsdemo-nodejs" "ecsdemo-frontend" "ecsdemo-platform" )
for i in "${files[@]}"
do 
    echo $i
    lines=($(grep -Fn '#ammmesh-xray-uncomment' ~/environment/${i}/cdk/app.py | cut -f1 -d:))
    unstart=$((${lines[0]} + 1))
    unend=$((${lines[1]} - 1))
    sed -i "${unstart},${unend} s/# //" ~/environment/${i}/cdk/app.py 
done

files=( "ecsdemo-crystal" "ecsdemo-nodejs" "ecsdemo-frontend" "ecsdemo-platform" )
for i in "${files[@]}"
do 
    sed -i -e '/AWSXRayDaemonWriteAccess/s/# //' ~/environment/${i}/cdk/app.py
done

# pip it
echo "pip requirements"

files=( "ecsdemo-crystal" "ecsdemo-nodejs" "ecsdemo-frontend" "ecsdemo-platform" )
for i in "${files[@]}"
do
    pip install --upgrade -r ~/environment/${i}/cdk/requirements.txt 
done





