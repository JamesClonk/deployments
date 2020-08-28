#!/bin/bash
set -e
set -u

kbld relocate -f "image.lock.yml" --repository docker.io/jamesclonk/prometheus --lock-output "../templates/image.lock.yml"
