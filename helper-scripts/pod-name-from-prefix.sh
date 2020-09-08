#!/bin/bash

if [  $# -le 2 ]
then
	echo "Finds pod name starting with prefix as third argument"
	echo -e "\nUsage:\n$0 [config file name] [context name] [prefix] \n"
	exit 1
fi

KUBE_CONFIG=$1
KUBE_CONTEXT=$2
PREFIX=$3
PREFIX_WITH_HYPHEN=$PREFIX-

echo "Searching for a pod whose name starts with [$PREFIX_WITH_HYPHEN*]"

KUBE_CMD=`kubectl --kubeconfig=$KUBE_CONFIG --context=$KUBE_CONTEXT get pod -o jsonpath='{.items[*].metadata.name}'`

for podName in $KUBE_CMD
do
    if [[ $podName == $PREFIX_WITH_HYPHEN* ]]
    then
        POD_NAME=$podName
    fi

    if [[ $podName == $PREFIX ]]
    then
        echo "Found exact match. Will be using exact value."

        if [ "x$POD_NAME" != "x" ]
        then
            echo "Already found a pod whose name started with $PREFIX_WITH_HYPHEN"
            echo "Potentially a deploy is in progress"
            POD_NAME="" #setting to nothing
        else
            POD_NAME=$podName
        fi
    fi
done

if [ "x$POD_NAME" == "x" ]
then
    echo "No pod starting with [$PREFIX_WITH_HYPHEN*] found."
    echo "Available pods are: "
    echo $KUBE_CMD | perl -pe 's/(.*?)\s/- \1 \n/g'
    exit 1
else
    echo "Using $POD_NAME"
fi
