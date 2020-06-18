#!/bin/bash

# fail on error
set -e

# status
APP_NAME=$(basename "$PWD")
kapp inspect --app ${APP_NAME} --tree
