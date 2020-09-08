#!/bin/bash

R=`which jq 2>/dev/null`

if [  $? -ne 0 ]
then
	echo "Please install 'jq' binary"
	exit 1
fi

R=`which drone 2>/dev/null`

if [  $? -ne 0 ]
then
	echo "Please install 'drone' binary"
	exit 1
fi

R=`drone --version 2>/dev/null`

if [  $? == "drone version 0.8.6" ]
then
	echo "Please install 'drone' version 0.8.6 binary"
	exit 1
fi

if [[ -z "${DRONE_SERVER}" ]]; then
  echo "Please define the DRONE_SERVER env var"
	exit 1
fi

if [[ -z "${DRONE_TOKEN}" ]]; then
  echo "Please define the DRONE_TOKEN env var"
	exit 1
fi
