cd ~/environment
files=( "ecsdemo-crystal" "ecsdemo-nodejs" "ecsdemo-frontend" "ecsdemo-platform" )
for i in "${files[@]}"
do
rm -rf ~/environment/${i}
done

git clone https://github.com/aws-containers/ecsdemo-platform
git clone https://github.com/aws-containers/ecsdemo-frontend
git clone https://github.com/aws-containers/ecsdemo-nodejs
git clone https://github.com/aws-containers/ecsdemo-crystal