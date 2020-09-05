#!/bin/bash
set -e
set -u

kbld relocate -f "loki.image.lock.yml" --repository docker.io/jamesclonk/loki --lock-output "../templates/loki.image.lock.yml"
kbld relocate -f "promtail.image.lock.yml" --repository docker.io/jamesclonk/loki --lock-output "../templates/promtail.image.lock.yml"
