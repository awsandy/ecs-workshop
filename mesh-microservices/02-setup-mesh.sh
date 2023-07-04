# platform

echo "Mesh edits"

# platform
sed -i -e '/self.appmesh()/s/# //' ~/environment/ecsdemo-platform/cdk/app.py

## Crystal
echo "Crystal"

lines=$(grep -Fn '#appmesh-proxy-uncomment' ~/environment/ecsdemo-crystal/cdk/app.py)
unstart=$(echo $lines | awk '{print $1}' | cut -f1 -d':')
unend=$(echo $lines | awk '{print $3}' | cut -f1 -d':')
if [[ "$unend" != "" ]]; then
    comm=$(printf "sed -i '%s,%s s/#//' ~/environment/ecsdemo-crystal/cdk/app.py" $unstart $unend)
    echo $comm
    eval $comm
fi
echo "self edit"
sed -i -e "/self.appmesh()/s/# //" ~/environment/ecsdemo-crystal/cdk/app.py

# nodejs
echo "nodejs"
lines=$(grep -Fn '# appmesh-proxy-uncomment' ~/environment/ecsdemo-nodejs/cdk/cdk/nodejsservice.py)
unstart=$(echo $lines | awk '{print $1}' | cut -f1 -d':')
unend=$(echo $lines | awk '{print $3}' | cut -f1 -d':')
if [[ $unund != "" ]]; then
    comm=$(printf "sed -i '%s,%s s/#//' ~/environment/ecsdemo-nodejs/cdk/cdk/nodejsservice.py" $unstart $unend)
    echo $comm
    eval $comm
fi

echo "self edit"
sed -i -e "self.appmesh()/s/# //" ~/environment/ecsdemo-nodejs/cdk/cdk/nodejsservice.py

echo "frontend"

# frontend

echo "Commenting previous frontend class"
sed -i -e '/FrontendService(app, stack_name, env=_env)/s/^#*/#/' ~/environment/ecsdemo-frontend/cdk/app.py
echo "Uncommenting new frontend class"
sed -i -e "/FrontendServiceMesh(app, stack_name, env=_env)/s/# //" ~/environment/ecsdemo-frontend/cdk/app.py
