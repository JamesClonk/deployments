#!/bin/bash
set -e
source ../setup.sh
KUBE_APP_NAME=base

# lock image
cat values.yml | envsubst -no-unset -no-empty | ytt --strict --ignore-unknown-comments -f templates -f - | kbld --lock-output image.lock.yml -f -
