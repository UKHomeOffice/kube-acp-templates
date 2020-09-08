#!/bin/bash

. ./common.sh $1

if [  $# -le 1 ] 
then 
	echo "Describe pods for a context."
	echo -e "\nUsage:\n$0 [config file name] [context name] \n"
	exit 1
fi

KUBE_CMD="kubectl --kubeconfig=$1 --context=$2"

rm -f $2-details.log

$KUBE_CMD get po | awk 'NR>1{print $1;}' > pods.txt

for f in $(cat pods.txt)
do
	echo -------------------$f----------------- >> $2-details.log
	$KUBE_CMD describe pod $f >> $2-details.log
done

$KUBE_CMD describe deployments >> $2-details.log

. ./unset.sh