

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







