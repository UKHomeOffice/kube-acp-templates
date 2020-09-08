#!/bin/bash

R=`which drone-trigger 2>/dev/null`

if [  $? -ne 0 ]
then
	echo "Please install 'drone-trigger' binary"
	echo "https://github.com/UKHomeOffice/drone-trigger"
	exit 1
fi

if [ -z ${DRONE_SERVER} ]
then
	echo "The environment variable DRONE_SERVER must be set."
	echo "eg. https://drone-gitlab.digital.homeoffice.gov.uk"
	exit 1
fi

if [ -z ${DRONE_TOKEN} ]
then
	echo "The environment variable DRONE_TOKEN must be set."
	exit 1
fi
