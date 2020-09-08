#!/bin/bash
# Unset all of the credential tokens in case they are commited to the config file

kubectl config  --kubeconfig=acpconfig set-credentials pds-dev --token="REPLACE" >> /dev/null
kubectl config  --kubeconfig=acpconfig set-credentials pds-prod --token="REPLACE" >> /dev/null