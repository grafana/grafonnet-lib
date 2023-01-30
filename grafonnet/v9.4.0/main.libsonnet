local grafonnet = import './base.libsonnet';
local schemas = import './grafana-schemas.libsonnet';
local version = import './grafana-version';
grafonnet.new(schemas, version)
