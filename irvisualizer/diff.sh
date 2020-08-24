#!/bin/bash
set -e
source ../setup.sh

# diff
kapp app-change list --app ${KUBE_APP_NAME}
cat values.yml | envsubst -no-unset -no-empty | ytt --strict --ignore-unknown-comments -f templates -f - | kbld -f - -f image.lock.yml | kapp deploy --app ${KUBE_APP_NAME} ${KAPP_DIFF} --diff-run -f -
