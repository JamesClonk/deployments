#!/bin/bash

# # check for modern envsubst with flags
# ENVSUBST=envsubst
# if envsubst -h 2>&1 | grep -q 'no-empty'; then
# 	ENVSUBST="envsubst -no-unset -no-empty"
# fi
# fail on error
set -e

# deploy
echo "deploying [$(basename "$PWD")] to [$(kubectl config current-context)] ..."
kubectl kustomize $(kubectl config current-context) | envsubst -no-unset -no-empty | kubectl apply -f -
echo "done!"
