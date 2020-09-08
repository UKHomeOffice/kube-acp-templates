#!/bin/bash

. ./common.sh $1

if [  $# -le 1 ] 
then 
	echo "Port forward a running pod."
	echo -e "\nUsage:\n$0 [config file name] [context name] [config map name]\n"
	exit 1
fi
#kubectl version
kubectl --kubeconfig=$1 --context=$2 edit configmap $3

. ./unset.sh
