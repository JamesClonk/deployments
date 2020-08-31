#!/bin/bash
set -e
source ../setup.sh

# status
kapp app-change list --app ${KUBE_APP_NAME}
kapp inspect --app ${KUBE_APP_NAME} --tree
