#!/bin/bash
set -e
source ../setup.sh

# lock image
cat values.yml | envsubst -no-unset -no-empty | ytt --ignore-unknown-comments -f templates -f - | kbld --lock-output image.lock.yml -f -
