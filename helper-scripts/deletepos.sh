#!/bin/bash

. ./common.sh $1

if [  $# -le 2 ]
then 
	echo "Delete specified pod. Prompts for deletion."
	echo -e "\nUsage:\n$0 [config file name] [context name] [pod partial name] \n"
	exit 1
fi

kubectl --kubeconfig=$1 --context=$2 get po | awk 'NR>1{print $1;}' > pods.txt

for f in $(grep $3 pods.txt)
do
	echo
	echo Delete pod $f
	read -p "Continue [Y/N]" -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		kubectl --kubeconfig=$1 --context=$2 delete po $f
	fi
done

. ./unset.sh