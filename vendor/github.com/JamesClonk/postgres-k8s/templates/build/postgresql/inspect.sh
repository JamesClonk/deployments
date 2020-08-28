#!/bin/bash
set -e
set -u

helm inspect values "$(pwd)/vendor/bitnami/postgresql" > postgresql.values
