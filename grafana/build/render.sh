#!/bin/bash
set -e
set -u

helm template grafana --namespace=grafana "$(pwd)/charts/grafana" --values="values.yml" |
    ytt --ignore-unknown-comments -f - > "../templates/rendered/grafana.yml"
kbld --lock-output "image.lock.yml" -f "../templates" >/dev/null

kbld relocate -f "image.lock.yml" --repository docker.io/jamesclonk/grafana --lock-output "../templates/image.lock.yml"
