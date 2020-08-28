#!/bin/bash
set -e
set -u

helm template prometheus --namespace=prometheus "$(pwd)/charts/prometheus" --values="values.yml" |
    ytt --ignore-unknown-comments -f - > "../templates/rendered/prometheus.yml"
kbld --lock-output "image.lock.yml" -f "../templates" >/dev/null

kbld relocate -f "image.lock.yml" --repository docker.io/jamesclonk/prometheus --lock-output "../templates/image.lock.yml"
