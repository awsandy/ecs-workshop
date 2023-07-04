# platform
echo "save"

echo "Mesh edits"

# platform
cd ~/environment/ecsdemo-platform/cdk

sed -i -e '/self.appmesh()/s/# //' ~/environment/ecsdemo-platform/cdk/app.py
pip install --upgrade -r ~/environment/ecsdemo-platform/cdk/requirements.txt 

## Crystal

lines=($(grep -Fn '#appmesh-proxy-uncomment' ~/environment/ecsdemo-crystal/cdk/app.py | cut -f1 -d:))
unstart=$((${lines[0]} + 1))
unend=$((${lines[1]} - 1))
sed -i "${unstart},${unend} s/# //" ~/environment/ecsdemo-crystal/cdk/app.py 

sed -i -e '/self.appmesh()/s/# //' ~/environment/ecsdemo-crystal/cdk/app.py
pip install --upgrade -r ~/environment/ecsdemo-nodejs/cdk/requirements.txt

# nodejs
lines=($(grep -Fn '#appmesh-proxy-uncomment' ~/environment/ecsdemo-nodejs/cdk/app.py | cut -f1 -d:))
unstart=$((${lines[0]} + 1))
unend=$((${lines[1]} - 1))
sed -i "${unstart},${unend} s/# //" ~/environment/ecsdemo-nodejs/cdk/app.py 

sed -i -e '/self.appmesh()/s/# //' ~/environment/ecsdemo-nodejs/cdk/app.py
pip install --upgrade -r ~/environment/ecsdemo-nodejs/cdk/requirements.txt 






echo "XRay edits"



files=( "ecsdemo-crystal" "ecsdemo-nodejs" "ecsdemo-frontend" "ecsdemo-platform" )
for i in "${files[@]}"
do 
    sed -i -e '/ENABLE_ENVOY_XRAY_TRACING/s/# //' ~/environment/${i}/cdk/app.py
done

files=( "ecsdemo-crystal" "ecsdemo-nodejs" "ecsdemo-frontend" "ecsdemo-platform" )
for i in "${files[@]}"
do 
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

files=( "ecsdemo-crystal" "ecsdemo-nodejs" "ecsdemo-frontend" "ecsdemo-platform" )
for i in "${files[@]}"
do
    pip install --upgrade -r ~/environment/${i}/cdk/requirements.txt 
done





