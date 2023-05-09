bootstrap: ## bootstrap a host (host=host1)
ifeq ($(strip $(host)),)
	$(error host is not set)
endif
	ansible-playbook -b playbooks/bootstrap.yml -k -e "hostname=$(host)"

run: ## run a playbook (host=host1)
ifeq ($(strip $(host)),)
	$(error host is not set)
endif
	ansible-playbook -b run.yml --limit $(host)

galaxy-install: ## install galaxy roles
	ansible-galaxy install -r requirements.yml


.PHONY: help

help:
	@eval $$(sed -r -n 's/^([a-zA-Z0-9_-]+):.*?##\s?(.*)$$/printf "\\033[36m%-30s\\033[0m %s\\n" "\1" "\2" ;/; ta; b; :a p' $(MAKEFILE_LIST) | sort)

.DEFAULT_GOAL := help
