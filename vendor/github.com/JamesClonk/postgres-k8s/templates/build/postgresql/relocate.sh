#!/bin/bash
set -e
set -u

kbld relocate -f "image.lock.yml" --repository docker.io/jamesclonk/postgresql --lock-output "../../postgresql/image.lock.yml"
