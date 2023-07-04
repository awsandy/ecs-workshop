# platform

echo "Mesh edits"

# platform
cd ~/environment/ecsdemo-platform/cdk
sed -i -e '/self.appmesh()/s/# //' ~/environment/ecsdemo-platform/cdk/app.py

## Crystal
echo "Crystal"

lines=($(grep -Fn '#appmesh-proxy-uncomment' ~/environment/ecsdemo-crystal/cdk/app.py | cut -f1 -d:))
unstart=$((${lines[0]} + 1))
unend=$((${lines[1]} - 1))
sed -i "${unstart},${unend} s/# //" ~/environment/ecsdemo-crystal/cdk/app.py 
sed -i -e "/self.appmesh()/s/# //" ~/environment/ecsdemo-crystal/cdk/app.py


# nodejs
echo "nodejs"
lines=($(grep -Fn '#appmesh-proxy-uncomment' ~/environment/ecsdemo-nodejs/cdk/app.py | cut -f1 -d:))
unstart=$((${lines[0]} + 1))
unend=$((${lines[1]} - 1))
sed -i "${unstart},${unend} s/# //" ~/environment/ecsdemo-nodejs/cdk/app.py 
sed -i -e '"self.appmesh()/s/# //" ~/environment/ecsdemo-nodejs/cdk/app.py

echo "frontend"

# frontend

#Commenting previous class
sed -i -e '/FrontendService(app, stack_name, env=_env)/s/^#*/#/' ~/environment/ecsdemo-frontend/cdk/app.py 
#Uncommenting new class
sed -i -e "/FrontendServiceMesh(app, stack_name, env=_env)/s/# //" ~/environment/ecsdemo-frontend/cdk/app.py 






