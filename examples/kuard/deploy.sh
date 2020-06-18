#!/bin/bash

# fail on error
set -e

# deploy
APP_NAME=$(basename "$PWD")
echo "deploying [${APP_NAME}] to [$(kubectl config current-context)] ..."
kubectl kustomize $(kubectl config current-context) | envsubst -no-unset -no-empty | kapp -y deploy --app ${APP_NAME} --diff-changes -f -
echo "done!"
