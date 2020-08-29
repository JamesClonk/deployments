#!/bin/bash
set -e
source ../setup.sh

# diff
kapp app-change list --app ${KUBE_APP_NAME}
cat values.yml | envsubst -no-unset -no-empty | ytt --ignore-unknown-comments -f templates -f - |
  sed "s/__BACKMAN_USERNAME__/${BACKMAN_USERNAME}/" | kbld -f - | kapp deploy --app ${KUBE_APP_NAME} ${KAPP_DIFF} --diff-run -f -
