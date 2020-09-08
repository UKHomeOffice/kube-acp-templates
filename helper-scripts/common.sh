#!/bin/bash

R=`which jq 2>/dev/null`

if [  $? -ne 0 ]
then
	echo "Please install 'jq' binary"
	exit 1
fi

R=`which kubectl 2>/dev/null`

if [  $? -ne 0 ]
then
	echo "Please install 'kubectl' binary"
	exit 1
fi

# Display the tokens currently in the environment
echo "Access Summary"
if [ -z ${KUBE_TOKEN} ]
then
	echo "✘ - Access to ACP Notprod"
else
	echo "✔ - Access to ACP Notprod"
fi

if [ -z ${KUBE_TOKEN_PROD} ]
then
	echo "✘ - Access to ACP Prod"
else
	echo "✔ - Access to ACP Prod"
fi
# Set the tokens in the config file for your access
kubectl config --kubeconfig=acpconfig set-credentials pds-dev --token=${KUBE_TOKEN} >> /dev/null
kubectl config --kubeconfig=acpconfig set-credentials pds-prod --token=${KUBE_TOKEN_PROD} >> /dev/null