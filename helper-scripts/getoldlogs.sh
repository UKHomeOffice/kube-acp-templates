#!/bin/bash

. ./common.sh $1

if [  $# -le 1 ]
then 
	echo "Download previous logs for containers in a pod. Prompts for download."
	echo -e "\nUsage:\n$0 [config file name] [context name] \n"
	exit 1
fi

today=`date '+%Y_%m_%d__%H_%M'`

kubectl --kubeconfig=$1 --context=$2 --output json get po > json-$today.txt

cat json-$today.txt | jq --raw-output '.items[] | .metadata.name + ":" + .spec.containers[].name' > podcontainers.txt

for f in $(cat podcontainers.txt)
do
    c=(${f/:/ })
	echo
	echo Getting logs for ${c[0]} with container name ${c[1]}
	read -p "Continue [Y/N]" -n 1 -r
	echo

	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		kubectl --kubeconfig=$1 --context=$2 logs ${c[0]} -c ${c[1]} -p=true > $2-$f-$today.old.log
	fi
done

. ./unset.sh