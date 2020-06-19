#!/bin/bash
set -e

function install_tool {
	TOOL_NAME=$1
	TOOL_URL=$2
	if [ ! -f "$HOME/bin/$TOOL_NAME" ]; then
		echo "installing [$TOOL_NAME] ..."
		wget "$TOOL_URL" -O "$HOME/bin/$TOOL_NAME"
		chmod +x "$HOME/bin/$TOOL_NAME"
	fi
}

# $HOME/bin
if [ ! -d "$HOME/bin" ]; then mkdir "$HOME/bin"; fi
export PATH="$HOME/bin:$PATH"

# install tools
install_tool "envsubst" "https://github.com/JamesClonk/envsubst/releases/download/v1.1.1/envsubst_1.1.1_Linux-64bit"
install_tool "kapp" "https://github.com/k14s/kapp/releases/download/v0.30.0/kapp-linux-amd64 "

# vars
export KUBE_ENVIRONMENT=$(kubectl config current-context)
export APP_NAME=$(basename "$PWD")
