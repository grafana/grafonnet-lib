local grafonnet = import 'github.com/grafana/grafonnet-lib/gen/grafonnet-gen/base.libsonnet';
local schemas = import 'grafana-schemas/imports.libsonnet';
local version = import './grafana-version';
grafonnet.new(schemas, version)
