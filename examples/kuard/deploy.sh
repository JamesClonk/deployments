#!/bin/bash

# # check for modern envsubst with flags
# ENVSUBST=envsubst
# if envsubst -h 2>&1 | grep -q 'no-empty'; then
# 	ENVSUBST="envsubst -no-unset -no-empty"
# fi
# fail on error
set -e

# deploy
echo "deploying ..."
cat deployment.yml | envsubst -no-unset -no-empty | kubectl apply -f -
echo "done!"
