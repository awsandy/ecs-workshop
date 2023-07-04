files=( "ecsdemo-crystal" "ecsdemo-nodejs" "ecsdemo-frontend" "ecsdemo-platform" )
for i in "${files[@]}"
do 
    echo $i
    cd ~/environment/${i}/cdk
    cdk synth
    cdk diff
    cdk deploy
done