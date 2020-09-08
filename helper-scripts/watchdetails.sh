#!/bin/bash

. ./common.sh $1

cleanup ()
{
    . ./unset.sh
    exit 0
}

trap cleanup SIGINT SIGTERM

if [  $# -le 1 ] 
then 
	echo "Display pods, rcs and services for a context.  With looping"
	echo -e "\nUsage:\n$0 [config file name] [context name] \n"
	exit 1
fi

KUBE_GET_CMD="kubectl --kubeconfig=$1 --context=$2 get"

sleep 2

while [ 1 ]
do

clear
echo `date`

echo
echo "PODS ************************************"

kubectl --kubeconfig=$1 --context=$2 get pod

sleep 5

done

. ./unset.sh