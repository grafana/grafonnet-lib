local grafana = import 'grafonnet/grafana.libsonnet';
local prometheus = grafana.prometheus;

{
  basic: prometheus.target('up'),
  advanced: prometheus.target(
    'apache_up',
    datasource='prom1',
    instant=true,
    intervalFactor=1,
    interval='1m',
    legendFormat='{{instance}}'
  ),
  heatmap: prometheus.target(
    'heatmap',
    format='heatmap',
  ),
}
