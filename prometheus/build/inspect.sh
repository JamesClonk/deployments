#!/bin/bash
set -e
set -u

helm inspect values "$(pwd)/charts/prometheus" > prometheus.values
