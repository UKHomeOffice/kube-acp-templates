#!/bin/bash

. ./common.sh $1

if [  $# -le 2 ]
then 
	echo "Set secrets"
	echo -e "\nUsage:\n$0 [config file name] [context name] [secret file name] \n"
	exit 1
fi

kubectl --kubeconfig=$1 --context=$2 apply -f $3

. ./unset.sh
