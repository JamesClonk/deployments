#!/bin/bash
set -e
set -u

kbld relocate -f "image.lock.yml" --repository docker.io/jamesclonk/postgresql-ha --lock-output "../../postgresql-ha/image.lock.yml"
