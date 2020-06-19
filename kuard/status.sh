#!/bin/bash
set -e
source ../utils.sh

# status
kapp inspect --app ${APP_NAME} --tree
