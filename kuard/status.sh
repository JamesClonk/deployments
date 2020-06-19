#!/bin/bash
set -e
source ../setup.sh

# status
kapp inspect --app ${KUBE_APP_NAME} --tree
