#!/bin/bash
set -e
source ../setup.sh

# lock image
cat values.yml | envsubst -no-unset -no-empty |
	ytt --strict --ignore-unknown-comments -f templates -f - |
	kbld -f - --lock-output "image.lock.yml"
kbld relocate -f "image.lock.yml" --repository docker.io/jamesclonk/msteams --lock-output "image.lock.yml"
