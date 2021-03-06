#!/bin/bash
set -e
source ../setup.sh

# deploy
echo "deploying [${KUBE_APP_NAME}] ..."
cat values.yml | envsubst -no-unset -no-empty | ytt --strict --ignore-unknown-comments -f templates -f - | kbld -f - -f image.lock.yml | kapp -y deploy --app ${KUBE_APP_NAME} ${KAPP_DIFF} -f -
kapp -y app-change garbage-collect --app ${KUBE_APP_NAME} --max 3
echo "done!"
