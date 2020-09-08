#!/bin/bash

. ./common.sh $1

if [  $# -le 1 ] 
then 
	echo "Get secrets"
	echo -e "\nUsage:\n$0 [config file name] [context name] \n"
	exit 1
fi

kubectl --kubeconfig=$1 --context=$2 describe secret $3
kubectl --kubeconfig=$1 --context=$2 get secret $3 -o yaml > $2_$3.yaml

. ./unset.sh