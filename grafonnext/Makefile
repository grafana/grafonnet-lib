ROOT:=$PWD

schemas/%:
	cd ../grafonnext-go && go run .
#	sh bin/mkschema.sh $* $(abspath schemas)

schemas.libsonnet:
	sh bin/mkimport.sh

static-%.libsonnet:
	jsonnet -S -J vendor -A version='$*' -A render='static' main.libsonnet | jsonnetfmt - > static-$*.libsonnet
