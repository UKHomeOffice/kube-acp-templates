#!/bin/bash

. ./common.sh $1

if [  $# -le 1 ] 
then 
	echo "Scale a deployment"
	echo -e "\nUsage:\n$0 [config file name] [context name] [current replicas] [desired replicas] [component name]\n"
	exit 1
fi

kubectl --kubeconfig=$1 --context=$2 scale --current-replicas=$3 --replicas=$4 --context=$2 deployment/$5

. ./unset.sh