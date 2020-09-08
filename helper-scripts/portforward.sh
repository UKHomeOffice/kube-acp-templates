#!/bin/bash

. ./common.sh $1

if [  $# -le 2 ] 
then 
	echo "Port forward a running pod."
	echo -e "\nUsage:\n$0 [config file name] [context name] [pod name] [local port] [remote port]\n"
	exit 1
fi

kubectl --kubeconfig=$1 --context=$2 port-forward $3 $4:$5

. ./unset.sh