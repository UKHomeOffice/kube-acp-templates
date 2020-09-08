#!/usr/bin/env bash

if [  $# -le 1 ]
then
	echo "Apply a config file to the cluster"
	echo -e "\nUsage:\n$0 [config file name] [context name] [file name and path] \n"
	exit 1
fi

. ./common.sh $1

kubectl --kubeconfig=$1 --context=$2 apply -f $3

. ./unset.sh