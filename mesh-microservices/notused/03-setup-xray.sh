echo "XRay edits"

files=("ecsdemo-crystal" "ecsdemo-frontend" "ecsdemo-platform")
for i in "${files[@]}"; do
    sed -i -e '/ENABLE_ENVOY_XRAY_TRACING/s/# //' ~/environment/${i}/cdk/app.py
    echo "check"
    grep ENABLE_ENVOY_XRAY_TRACING ~/environment/${i}/cdk/app.py
done
sed -i -e '/ENABLE_ENVOY_XRAY_TRACING/s/# //' ~/environment/ecsdemo-nodejs/cdk/cdk/nodejsservice.py
grep ENABLE_ENVOY_XRAY_TRACING ~/environment/ecsdemo-nodejs/cdk/cdk/nodejsservice.py

#########
echo "ammmesh-xray-uncomment"

files=("ecsdemo-crystal" "ecsdemo-frontend" "ecsdemo-platform")
for i in "${files[@]}"; do

    lines=$(grep -Fn '#appmesh-xray-uncomment' ~/environment/${i}/cdk/app.py)
    if [[ "$lines" != "" ]]; then
        echo $lines
        unstart=$(echo $lines | awk '{print $1}' | cut -f1 -d':')
        unend=$(echo $lines | awk '{print $3}' | cut -f1 -d':')

        echo "$unstart $unend"
        if [[ "$unend" != "" ]]; then
            comm=$(printf "sed -i '%s,%s s/#//' ~/environment/${i}/cdk/app.py" $unstart $unend)
            echo $comm
            eval $comm
            echo "check"
            grep appmesh-xray-uncomment  ~/environment/${i}/cdk/app.py
        fi
    else
        echo "empty lines for $i"
    fi

done

lines=$(grep -Fn '#appmesh-xray-uncomment' ~/environment/ecsdemo-nodejs/cdk/cdk/nodejsservice.py)
if [[ "$lines" != "" ]]; then
echo $lines
unstart=$(echo $lines | awk '{print $1}' | cut -f1 -d':')
unend=$(echo $lines | awk '{print $3}' | cut -f1 -d':')

echo "$unstart $unend"
if [[ "$unend" != "" ]]; then
    comm=$(printf "sed -i '%s,%s s/#//' ~/environment/ecsdemo-nodejs/cdk/cdk/nodejsservice.py" $unstart $unend)
    echo $comm
    eval $comm
    echo "check"
    grep appmesh-xray-uncomment ~/environment/ecsdemo-nodejs/cdk/cdk/nodejsservice.py
fi
else
    echo "empty lines for nodejs"
fi


echo "AWSXRayDaemonWriteAccess uncomment"

files=("ecsdemo-crystal" "ecsdemo-frontend" "ecsdemo-platform")
for i in "${files[@]}"; do
    
    sed -i -e '/AWSXRayDaemonWriteAccess/s/# //' ~/environment/${i}/cdk/app.py
    echo "check"
    grep AWSXRayDaemonWriteAccess ~/environment/${i}/cdk/app.py
done

sed -i -e '/AWSXRayDaemonWriteAccess/s/# //' ~/environment/ecsdemo-nodejs/cdk/cdk/nodejsservice.py
echo "check..."
grep AWSXRayDaemonWriteAccess ~/environment/ecsdemo-nodejs/cdk/cdk/nodejsservice.py


#echo "comment check nodejs"  
#grep '#' ~/environment/ecsdemo-nodejs/cdk/cdk/nodejsservice.py
#grep '#' ~/environment/ecsdemo-frontend/cdk/app.py
#grep '#' ~/environment/ecsdemo-crystal/cdk/app.py
#grep '#' ~/environment/ecsdemo-platform/cdk/app.py
