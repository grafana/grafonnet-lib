local grafonnet = import 'github.com/grafana/grafonnet-lib/gen/grafonnet-gen/main.libsonnet';
local schemas = import './schemas.libsonnet';
local version = importstr './grafana-version';
grafonnet.new(schemas, version)
