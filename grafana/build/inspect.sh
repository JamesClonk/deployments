#!/bin/bash
set -e
set -u

helm inspect values "$(pwd)/charts/grafana" > grafana.values
