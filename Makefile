.DEFAULT_GOAL := help
SHELL := /bin/bash
APP ?= $(shell basename $$(pwd))
COMMIT_SHA = $(shell git rev-parse --short HEAD)
ARGS = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`
DEFAULT_APP = kuard

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