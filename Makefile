.DEFAULT_GOAL := help
SHELL := /bin/bash
APP ?= $(shell basename $$(pwd))
COMMIT_SHA = $(shell git rev-parse --short HEAD)

.PHONY: help
## help: prints this help message
help:
	@echo "Usage:"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

.PHONY: deploy
## deploy: deploys all applications to kubernetes
deploy:
	./deploy_all.sh

.PHONY: setup
## setup: setup working environment
setup:
	./setup.sh; set +e

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

.PHONY: target-prod
## target-prod: targets the production kubernetes environment
target-prod:
	@kubectl config use-context prod
