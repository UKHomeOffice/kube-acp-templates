#!/bin/sh
kubectl create secret generic <secret_name> --from-literal=<secret_name>=${ENV_VAR_NAME}
