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
		-u $$UID \
		-v $$PWD:$$PWD \
		-w $$PWD \
		trotttrotttrott/jsonnetdoc:4f806c6 \
		grafonnet --markdown \
		> docs/api-docs.md
