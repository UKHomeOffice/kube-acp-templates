#!/bin/bash

. ./common.sh $1

if [  $# -le 1 ] 
then 
	echo "Display pods, rcs and services for a context."
	echo -e "\nUsage:\n$0 [config file name] [context name] \n"
	exit 1
fi

KUBE_GET_CMD="kubectl --kubeconfig=$1 --context=$2 get"

echo `date`

echo
echo "PODS ************************************"
$KUBE_GET_CMD pod

#echo
#echo "REPLICATION CONTROLLERS *****************"
#$KUBE_GET_CMD rc

echo
echo "DEPLOYMENTS *****************************"
$KUBE_GET_CMD deployments

echo
echo "SERVICES ****************"
$KUBE_GET_CMD services

echo
echo "Getting json..."
$KUBE_GET_CMD pod --output json > $2-json.txt

. ./unset.sh
