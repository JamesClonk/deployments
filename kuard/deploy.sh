#!/bin/bash
set -e
source ../setup.sh

# deploy
echo "deploying [${KUBE_APP_NAME}] to [${KUBE_ENVIRONMENT}] ..."
kubectl kustomize ${KUBE_ENVIRONMENT} | envsubst -no-unset -no-empty | kapp -y deploy --app ${KUBE_APP_NAME} --diff-changes -f -
echo "done!"
