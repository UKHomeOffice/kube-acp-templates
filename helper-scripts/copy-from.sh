#!/bin/bash

. ./common.sh $1

if [  $# -le 2 ]
then
	echo "Copy from a running pod."
	echo -e "\nUsage:\n$0 [config file name] [context name] [pod name] [file name]\n"
	exit 1
fi

KUBE_CONFIG=$1
KUBE_CONTEXT=$2
ARG_POD_NAME=$3
FILE=$4
today=`date '+%Y_%m_%d__%H_%M'`

. ./pod-name-from-prefix.sh $KUBE_CONFIG $KUBE_CONTEXT $ARG_POD_NAME

kubectl --kubeconfig=$KUBE_CONFIG --context=$KUBE_CONTEXT cp $POD_NAME:/code/$FILE ${today}_${FILE}

. ./unset.sh