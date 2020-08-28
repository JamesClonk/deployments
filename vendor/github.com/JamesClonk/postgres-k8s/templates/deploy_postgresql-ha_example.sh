#!/bin/bash
set -e
set -u

# deploy
echo "deploying postgresql-ha example ..."
ytt -f postgresql-ha -f postgresql-ha_example.yml -v postgres.persistent_volume= |
	kbld -f - |
	kapp deploy -a postgres --diff-changes -f - -y
kapp -y app-change garbage-collect -a postgres --max 5
