#!/bin/bash
set -e
source ../setup.sh

# diff
kapp app-change list --app ${KUBE_APP_NAME}
kapp deploy --app ${KUBE_APP_NAME} --diff-changes --diff-run -f cert-manager.yml
