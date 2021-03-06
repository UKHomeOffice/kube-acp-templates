#!/bin/bash

. ./common.sh $1

if [  $# -le 1 ] 
then 
	echo "Get events for a context."
	echo -e "\nUsage:\n$0 [config file name] [context name] \n"
	exit 1
fi

kubectl --kubeconfig=$1 --context=$2 get events

. ./unset.sh