#!/bin/bash

# fail on error
set -e

# diff
APP_NAME=$(basename "$PWD")
kubectl kustomize $(kubectl config current-context) | envsubst -no-unset -no-empty | kapp deploy --app ${APP_NAME} --diff-changes --diff-run -f -
