#!/bin/bash

. ./common.sh $1

if [  $# -le 2 ]
then
	echo "Bash into a running pod."
	echo -e "\nUsage:\n$0 [config file name] [context name] [pod name]\n"
	exit 1
fi

KUBE_CONFIG=$1
KUBE_CONTEXT=$2
ARG_POD_NAME=$3

. ./pod-name-from-prefix.sh $KUBE_CONFIG $KUBE_CONTEXT $ARG_POD_NAME

kubectl --kubeconfig=$KUBE_CONFIG --context=$KUBE_CONTEXT --container=$4 exec -ti $POD_NAME -- sh

. ./unset.sh