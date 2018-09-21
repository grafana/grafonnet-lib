local grafana = import 'grafonnet/grafana.libsonnet';
local graphite = grafana.graphite;

{
  basic: graphite.target('metric'),
  advanced: graphite.target(
    '#A',
    datasource='graphite',
    hide=true,
    textEditor=false,
    targetFull='my.awesome.metric',
  ),
}
