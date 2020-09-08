#!/bin/bash

. ./common-drone.sh

if [  $# -le 1 ]
then
	echo "Promote a build to production."
	echo -e "\nUsage:\n$0 [number] [project]\n"
	exit 1
fi

read -p "Are you sure you want to continue? <y/N> " prompt

if [[ $prompt =~ [yY](es)* ]]
then
    drone-trigger -r $SERVICE_NAME/$2 --number $1 --drone-server $DRONE_SERVER --drone-token $DRONE_TOKEN -d PROD
fi
