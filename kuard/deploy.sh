#!/bin/bash
set -e
source ../utils.sh

# deploy
echo "deploying [${APP_NAME}] to [${KUBE_ENVIRONMENT}] ..."
kubectl kustomize ${KUBE_ENVIRONMENT} | envsubst -no-unset -no-empty | kapp -y deploy --app ${APP_NAME} --diff-changes -f -
echo "done!"
