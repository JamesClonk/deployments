#!/bin/bash
set -e
source ../setup.sh

# diff
kubectl kustomize ${KUBE_ENVIRONMENT} | envsubst -no-unset -no-empty | kapp deploy --app ${KUBE_APP_NAME} --diff-changes --diff-run -f -
