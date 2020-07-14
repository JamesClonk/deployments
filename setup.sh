#!/bin/bash
set -e

function install_tool {
	TOOL_NAME=$1
	TOOL_URL=$2
	if [ ! -f "$HOME/bin/${TOOL_NAME}" ]; then
		echo "downloading [${TOOL_NAME}] ..."
		wget "${TOOL_URL}" -O "$HOME/bin/${TOOL_NAME}"
		chmod +x "$HOME/bin/${TOOL_NAME}"
	fi
}

function install_tool_from_tarball {
	TOOL_NAME=$1
	TOOL_URL=$2
	if [ ! -f "$HOME/bin/${TOOL_NAME}" ]; then
		echo "downloading [${TOOL_NAME}] ..."
		wget "${TOOL_URL}" -O "$HOME/bin/${TOOL_NAME}.tgz"
		echo "unpacking [${TOOL_NAME}.tgz] ..."
		tar -xvzf "$HOME/bin/${TOOL_NAME}.tgz" -C "$HOME/bin/" "${TOOL_NAME}"
		chmod +x "$HOME/bin/${TOOL_NAME}"
		rm -f "$HOME/bin/${TOOL_NAME}.tgz"
	fi
}

# $HOME/bin
if [ ! -d "$HOME/bin" ]; then mkdir "$HOME/bin"; fi
export PATH="$HOME/bin:$PATH"

# install tools
install_tool "kubectl" "https://storage.googleapis.com/kubernetes-release/release/v1.18.4/bin/linux/amd64/kubectl"
install_tool "envsubst" "https://github.com/JamesClonk/envsubst/releases/download/v1.1.1/envsubst_1.1.1_Linux-64bit"
install_tool "kapp" "https://github.com/k14s/kapp/releases/download/v0.30.0/kapp-linux-amd64"
install_tool "ytt" "https://github.com/k14s/ytt/releases/download/v0.28.0/ytt-linux-amd64"
install_tool_from_tarball "k9s" "https://github.com/derailed/k9s/releases/download/v0.20.5/k9s_Linux_x86_64.tar.gz"

# vars
export KUBE_APP_NAME=$(basename "$PWD")

# which env are we targetting?
if [ -z "${KUBE_ENVIRONMENT}" ]; then
	export KUBE_ENVIRONMENT=$(kubectl config current-context)
	if [ "${KUBE_ENVIRONMENT}" == "microk8s" ]; then
		export KUBE_ENVIRONMENT="local"
	fi
	if [ "${KUBE_ENVIRONMENT}" == "scaleway" ]; then
		export KUBE_ENVIRONMENT="prod"
	fi
	if [ "${KUBE_ENVIRONMENT}" == "production" ]; then
		export KUBE_ENVIRONMENT="prod"
	fi
	if [ "${KUBE_ENVIRONMENT}" == "int" ]; then
		export KUBE_ENVIRONMENT="test"
	fi
fi
# set test name if necessary
if [ "${KUBE_ENVIRONMENT}" == "test" ]; then
	export KUBE_APP_NAME="${KUBE_APP_NAME}.test"
fi

# what's the domain for that env?
export KUBE_DOMAIN_ALPHA="127.0.0.1.xip.io"
export KUBE_DOMAIN_BETA="127.0.0.1.xip.io"
if [ "${KUBE_ENVIRONMENT}" == "local" ]; then
	export KUBE_DOMAIN_ALPHA="127.0.0.1.xip.io"
	export KUBE_DOMAIN_BETA="127.0.0.1.xip.io"
fi
if [ "${KUBE_ENVIRONMENT}" == "test" ]; then
	export KUBE_DOMAIN_ALPHA="test.jamesclonk.io"
	export KUBE_DOMAIN_BETA="test.jamesclonk.com"
fi
if [ "${KUBE_ENVIRONMENT}" == "prod" ]; then
	export KUBE_DOMAIN_ALPHA="jamesclonk.io"
	export KUBE_DOMAIN_BETA="jamesclonk.com"
fi