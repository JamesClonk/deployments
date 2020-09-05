#!/bin/bash
set -e
set -u

helm template loki --namespace=loki "$(pwd)/charts/loki" --values="loki.values.yml" |
    ytt --ignore-unknown-comments -f - > "../templates/rendered/loki.yml"
kbld --lock-output "loki.image.lock.yml" -f "../templates" >/dev/null

kbld relocate -f "loki.image.lock.yml" --repository docker.io/jamesclonk/loki --lock-output "../templates/loki.image.lock.yml"

helm template promtail --namespace=loki "$(pwd)/charts/promtail" --values="promtail.values.yml" |
    ytt --ignore-unknown-comments -f - > "../templates/rendered/promtail.yml"
kbld --lock-output "promtail.image.lock.yml" -f "../templates" >/dev/null

kbld relocate -f "promtail.image.lock.yml" --repository docker.io/jamesclonk/loki --lock-output "../templates/promtail.image.lock.yml"
