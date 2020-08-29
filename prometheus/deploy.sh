#!/bin/bash
set -e
source ../setup.sh

# deploy
echo "deploying [${KUBE_APP_NAME}] ..."
cat values.yml | envsubst -no-unset -no-empty | ytt --ignore-unknown-comments -f templates -f - |
  sed "s/__BACKMAN_USERNAME__/${BACKMAN_USERNAME}/" | kbld -f - | kapp -y deploy --app ${KUBE_APP_NAME} ${KAPP_DIFF} -f -
kapp -y app-change garbage-collect --app ${KUBE_APP_NAME} --max 5
echo "done!"
