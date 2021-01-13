local grafana = import 'grafonnet/grafana.libsonnet';
local cloudmonitoring = grafana.cloudmonitoring;

{
  basic: cloudmonitoring.target(
    'kubernetes.io/container/cpu/request_utilization',
    'gcp-organization',
  ),
  advanced: cloudmonitoring.target(
    'kubernetes.io/container/cpu/request_utilization',
    'gcp-organization',
    filters=['resource.label.namespace_name', '=', 'default', 'AND', 'resource.label.container_name', '=', 'nginx'],
    groupBys=[],
    period='cloud-monitoring-auto',
    perSeriesAligner='ALIGN_INTERPOLATE',
    valueType='DOUBLE',
    crossSeriesReducer='REDUCE_MEAN',
    alias='CPU Request Utilization',
    metricKind='GAUGE',
  ),
}
