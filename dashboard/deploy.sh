#!/bin/bash
set -e
source ../setup.sh

# deploy
echo "deploying [${KUBE_APP_NAME}] to [${KUBE_ENVIRONMENT}] ..."
kubectl kustomize ${KUBE_ENVIRONMENT} | envsubst -no-unset -no-empty | kapp -y deploy --app ${KUBE_APP_NAME} ${KAPP_DIFF} -f -
kapp -y app-change garbage-collect --app ${KUBE_APP_NAME} --max 3
echo "done!"
