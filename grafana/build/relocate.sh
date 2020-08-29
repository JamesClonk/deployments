#!/bin/bash
set -e
set -u

kbld relocate -f "image.lock.yml" --repository docker.io/jamesclonk/grafana --lock-output "../templates/image.lock.yml"
