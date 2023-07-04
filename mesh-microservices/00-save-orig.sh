files=( "ecsdemo-crystal" "ecsdemo-nodejs" "ecsdemo-frontend" "ecsdemo-platform" )
for i in "${files[@]}"
do
cp ~/environment/${i}/cdk/app.py ~/environment/${i}/cdk/app.py.orig
done

