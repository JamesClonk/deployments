#!/bin/bash
set -e
source ../setup.sh

# diff
kapp app-change list --app ${KUBE_APP_NAME}
ytt -f templates -f values.yml | envsubst -no-unset -no-empty | kapp deploy --app ${KUBE_APP_NAME} --diff-changes --diff-run -f -
