#!/bin/bash

. ./common.sh $1

if [  $# -le 2 ]
then 
	echo "Delete specified secret from pod."
	echo -e "\nUsage:\n$0 [config file name] [context name] [secret name] \n"
	exit 1
fi

kubectl --kubeconfig=$1 --context=$2 delete secret $3

. ./unset.sh