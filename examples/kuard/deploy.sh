#!/bin/bash

# fail on error
set -e

if [ -z "${BASIC_AUTH}" ]; then
	echo "BASIC_AUTH must be set!"
	exit 1
fi

cat deployment.yml | envsubst | kubectl apply -f -
