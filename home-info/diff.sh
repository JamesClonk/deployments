#!/bin/bash
set -e
source ../setup.sh

# diff
kapp app-change list --app ${KUBE_APP_NAME}
kubectl kustomize ${KUBE_ENVIRONMENT} | envsubst -no-unset -no-empty | kapp deploy --app ${KUBE_APP_NAME} ${KAPP_DIFF} --diff-run -f -
