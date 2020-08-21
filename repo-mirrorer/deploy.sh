#!/bin/bash
set -e
source ../setup.sh

# delete first if there are changes
set +e
cat values.yml | envsubst -no-unset -no-empty | ytt --strict --ignore-unknown-comments -f templates -f - | kapp deploy --app ${KUBE_APP_NAME} ${KAPP_DIFF} --diff-run --diff-exit-status -f -
EXITCODE=$?
set -e
if [[ ${EXITCODE} != 2 ]]; then
	echo "deleting [${KUBE_APP_NAME}] ..."
	kapp -y delete --app ${KUBE_APP_NAME}
fi

# deploy
echo "deploying [${KUBE_APP_NAME}] ..."
cat values.yml | envsubst -no-unset -no-empty | ytt --strict --ignore-unknown-comments -f templates -f - | kapp -y deploy --app ${KUBE_APP_NAME} ${KAPP_DIFF} -f -
kapp -y app-change garbage-collect --app ${KUBE_APP_NAME} --max 3
echo "done!"
