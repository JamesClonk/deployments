#!/bin/bash
set -e
set -u

deployments=(
	# cluster basics, needed by/for everything else
	"base"
	"cert-manager"
	"dashboard"

	# metrics, monitoring, alerting, logs
	"prometheus"
	"grafana"
	"loki"

	# demo/test apps
	"cf-env"
	"kuard"

	# all your backups are belong to us!
	"backman"

	# actual useful apps go here..
	"jcio"
	"home-info"
	"irvisualizer"

	# also some cronjobs for good fun..
	"image-puller"
	"repo-mirrorer"
)

# deploy it all, all of it!
for deployment in ${deployments[@]}; do
	pushd $deployment
	./deploy.sh
	popd
	echo -e "\n\n"
done
