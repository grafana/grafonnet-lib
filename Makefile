UID = $(shell id -u $(USER))
GID = $(shell id -g $(USER))

help:         # Show this message.
	@echo "\nAvailable Targets:\n"
	@sed -ne '/@sed/!s/# //p' $(MAKEFILE_LIST)

test:         # Run all unit tests.
	@docker run --rm \
		-w $$PWD \
		-v $$PWD:$$PWD \
		-u $(UID):$(GID) \
		--entrypoint bash \
		bitnami/jsonnet:0.16.0 \
		tests.sh

test-update:  # Run all unit tests while copying test_output.json to compiled.json file.
	@docker run --rm \
		-w $$PWD \
		-v $$PWD:$$PWD \
		-u $(UID):$(GID) \
		--entrypoint bash \
		bitnami/jsonnet:0.16.0 \
		tests.sh update

e2e:          # Run all end-to-end tests.
	GRAFANA_VERSION=7.0.3 \
	docker-compose -f e2e/docker-compose.yml up \
		--abort-on-container-exit \
		--exit-code-from e2e

gen-api-docs: # Generate api-docs.md from source code comments.
	@docker run --rm \
		-w $$PWD \
		-v $$PWD:$$PWD \
		trotttrotttrott/jsonnetdoc:219e41b \
		grafonnet --markdown \
		> docs/api-docs.md

.PHONY: help test test-update e2e gen-api-docs
