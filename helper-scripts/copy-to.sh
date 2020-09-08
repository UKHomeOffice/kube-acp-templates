#!/bin/bash

. ./common.sh $1

if [  $# -le 2 ]
then
	echo "Copy to a running pod."
	echo -e "\nUsage:\n$0 [config file name] [context name] [pod name] [file_name]\n"
	exit 1
fi

KUBE_CONFIG=$1
KUBE_CONTEXT=$2
ARG_POD_NAME=$3
DIR=$4
FILE=$5
today=`date '+%Y_%m_%d__%H_%M'`

. ./pod-name-from-prefix.sh $KUBE_CONFIG $KUBE_CONTEXT $ARG_POD_NAME

kubectl --kubeconfig=$KUBE_CONFIG --context=$KUBE_CONTEXT cp "${DIR}/${FILE}" "$POD_NAME:/tmp/$FILE"

. ./unset.sh