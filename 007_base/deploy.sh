#!/bin/bash
set -e
source ../setup.sh
KUBE_APP_NAME=base

# deploy
echo "deploying base setup ..."
cat values.yml | envsubst -no-unset -no-empty | ytt --strict --ignore-unknown-comments -f templates -f - | kbld -f - -f image.lock.yml | kapp -y deploy --app ${KUBE_APP_NAME} ${KAPP_DIFF} -f -
kapp -y app-change garbage-collect --app ${KUBE_APP_NAME} --max 5
echo "done!"
