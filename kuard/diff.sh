#!/bin/bash
set -e
source ../utils.sh

# diff
kubectl kustomize ${KUBE_ENVIRONMENT} | envsubst -no-unset -no-empty | kapp deploy --app ${APP_NAME} --diff-changes --diff-run -f -
