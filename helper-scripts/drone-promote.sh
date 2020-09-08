#!/bin/bash

./drone-common.sh

function promote {
    read -p "Deploy $1 build $2 from UAT into PROD? [Y/N]" -n 1 -r < /dev/tty
	echo

	if [[ $REPLY =~ ^[Yy]$ ]]
	then
        echo drone-trigger -r $1 -number $2 -d PROD >> deploy.sh
	fi
}

echo "#!/bin/bash" > deploy.sh
echo "#!/bin/bash" > deploy-stg.sh

while read -r f1 f2 f3 f4 f5 f6;
do
    echo
    case $f6 in
        Y)
	    echo $f1 no action needed
        ;;
        N)
	    echo $f1 update required
        promote $f1 $f2
        ;;
        -)
	    echo $f1 new deployment required
	    promote $f1 $f2
        ;;
        *)
	    echo $f1 error - unknown state
        ;;
    esac
done < outputCOMB.txt

rm deploy-stg.sh
while read -r f1 f2 f3 f4 f5 f6;
do
    echo drone-trigger -r $f1 -number $f2 -d STG >> deploy-stg.sh
done < outputUAT.txt

rm deploy-uat.sh
while read -r f1 f2 f3 f4 f5 f6;
do
    echo drone-trigger -r $f1 -number $f2 -d UAT >> deploy-uat.sh
done < outputDEV.txt

rm deploy-prod.sh
while read -r f1 f2 f3 f4 f5 f6;
do
    echo drone-trigger -r $f1 -number $f2 -d PROD >> deploy-prod.sh
done < outputUAT.txt

echo
echo Build steps follow:
cat deploy.sh
echo