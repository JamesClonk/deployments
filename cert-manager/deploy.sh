#!/bin/bash
set -e
source ../setup.sh

# deploy
echo "deploying [${KUBE_APP_NAME}] to [${KUBE_ENVIRONMENT}] ..."
kapp -y deploy --app ${KUBE_APP_NAME} --diff-changes -f cert-manager.yml
kapp -y app-change garbage-collect --app ${KUBE_APP_NAME} --max 3
echo "done!"
