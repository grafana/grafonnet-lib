ROOT:=$PWD

schemas/%:
	sh bin/mkschema.sh $* $(abspath schemas)

schemas.libsonnet:
	sh bin/mkimport.sh
