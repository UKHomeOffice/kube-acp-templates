#!/bin/bash

. ./common.sh $1

if [  $# -le 4 ]
then 
	echo "Set secrets"
	echo -e "\nUsage:\n$0 [config file name] [context name] [secret key] [secret name] [secret value] \n"
	exit 1
fi

kubectl --kubeconfig=$1 --context=$2 delete secret $3
kubectl --kubeconfig=$1 --context=$2 create secret generic $3 --from-literal=$4=$5

. ./unset.sh
