#!/bin/bash
set -e
set -u

helm template postgresql --namespace=postgres "$(pwd)/vendor/bitnami/postgresql" --values="values.yml" |
    ytt --ignore-unknown-comments -f - > "../../postgresql/database/rendered/postgresql.yml"
kbld --lock-output "image.lock.yml" -f "../../postgresql" >/dev/null

kbld relocate -f "image.lock.yml" --repository docker.io/jamesclonk/postgresql --lock-output "../../postgresql/image.lock.yml"
