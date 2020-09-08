#!/bin/bash

. ./common-drone.sh

if [  $# -le 1 ]
then
	echo "Promote a build to demo."
	echo -e "\nUsage:\n$0 [number] [project]\n"
	exit 1
fi

drone-trigger -r $SERVICE_NAME/$2 --number $1 --drone-server $DRONE_SERVER --drone-token $DRONE_TOKEN -d UAT
