help:         # Show this message.
	@echo "\nAvailable Targets:\n"
	@sed -ne '/@sed/!s/# //p' $(MAKEFILE_LIST)

test:         # Run all unit tests.
	@docker run --rm \
		-w $$PWD \
		-v $$PWD:$$PWD \
		--entrypoint sh \
		sparkprime/jsonnet \
		tests.sh

test-update:  # Run all unit tests while copying test_output.json to compiled.json file.
	@docker run --rm \
		-w $$PWD \
		-v $$PWD:$$PWD \
		--entrypoint sh \
		sparkprime/jsonnet \
		tests.sh update

gen-api-docs: # Generate api-docs.md from source code comments.
	@docker run --rm \
		-w $$PWD \
		-v $$PWD:$$PWD \
		trotttrotttrott/jsonnetdoc:219e41b \
		grafonnet --markdown \
		> docs/api-docs.md
