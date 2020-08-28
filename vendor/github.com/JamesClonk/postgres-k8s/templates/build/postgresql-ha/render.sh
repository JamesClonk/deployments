#!/bin/bash
set -e
set -u

helm template postgres --namespace=postgres "$(pwd)/vendor/bitnami/postgresql-ha" --values="values.yml" |
    ytt --ignore-unknown-comments -f - |
    kbld --lock-output "image.lock.yml" -f - > "../../postgresql-ha/rendered/postgresql-ha.yml"
kbld relocate -f "image.lock.yml" --repository docker.io/jamesclonk/postgresql-ha --lock-output "../../postgresql-ha/image.lock.yml"
