help:        # Show this message.
	@echo "\nAvailable Targets:\n"
	@sed -ne '/@sed/!s/# //p' $(MAKEFILE_LIST)

test:        # Run all unit tests.
	@docker run \
		-w $$PWD \
		-v $$PWD:$$PWD \
		--entrypoint sh \
		sparkprime/jsonnet \
		tests.sh

test-update: # Run all unit tests while copying test_output.json to compiled.json file.
	@docker run \
		-w $$PWD \
		-v $$PWD:$$PWD \
		--entrypoint sh \
		sparkprime/jsonnet \
		tests.sh update
