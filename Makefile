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

.PHONY: target
## target: targets a kubernetes environment
target:
	@kubectl config use-context $(call ARGS,${DEFAULT_ENVIRONMENT})

cf-env kuard jcio home-info ircollector irvisualizer production prod testing test local microk8s:
	@exit $?
