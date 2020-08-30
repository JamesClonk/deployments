.DEFAULT_GOAL := help
SHELL := /bin/bash
APP ?= $(shell basename $$(pwd))
COMMIT_SHA = $(shell git rev-parse --short HEAD)
ARGS = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`
DEFAULT_APP = kuard
DEFAULT_ENVIRONMENT = local
.PHONY: $(MAKECMDGOALS)

.PHONY: help
## help: prints this help message
help:
	@echo "Usage:"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

.PHONY: deploy-all
## deploy-all: deploys all applications to kubernetes
deploy-all:
	@for dir in $$(find . -maxdepth 2 -type f -name 'deploy.sh' | sed -r 's|/[^/]+$$||' | sort | uniq); do pushd $$dir; ./deploy.sh || exit 1; popd; echo " "; done

.PHONY: deploy
## deploy: deploys applications to kubernetes
deploy:
	@cd $(call ARGS,${DEFAULT_APP}); ./deploy.sh

.PHONY: diff
## diff: shows application diff between local and kubernetes
diff:
	@cd $(call ARGS,${DEFAULT_APP}); ./diff.sh

.PHONY: status
## status: displays application status
status:
	@cd $(call ARGS,${DEFAULT_APP}); ./status.sh

.PHONY: dashboard-ui
## dashboard-ui: open kubernetes dashboard
dashboard-ui:
	sleep 2 && firefox 'https://127.0.0.1:4443' &
	@kubectl -n kubernetes-dashboard port-forward service/kubernetes-dashboard 4443:443

.PHONY: prometheus-ui
## prometheus-ui: open prometheus webui
prometheus-ui:
	sleep 2 && firefox 'http://127.0.0.1:8080' &
	@kubectl -n prometheus port-forward service/prometheus-server 8080:80

.PHONY: alertmanager-ui
## alertmanager-ui: open alertmanager webui
alertmanager-ui:
	sleep 2 && firefox 'http://127.0.0.1:8080' &
	@kubectl -n prometheus port-forward service/prometheus-alertmanager 8080:80

.PHONY: grafana-ui
## grafana-ui: open grafana webui
grafana-ui:
	sleep 2 && firefox 'http://127.0.0.1:8080' &
	@kubectl -n grafana port-forward service/grafana 8080:80

.PHONY: target
## target: targets a kubernetes environment
target:
	@kubectl config use-context $(call ARGS,${DEFAULT_ENVIRONMENT})

.PHONY: setup
## setup: setup working environment
setup:
	./setup.sh

007_base image-puller repo-mirrorer cf-env kuard jcio home-info ircollector irvisualizer prometheus grafana postgres production prod testing test local microk8s:
	@exit $?
