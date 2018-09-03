local grafana = import 'grafonnet/grafana.libsonnet';
local template = grafana.template;

{
  basic: template.datasource('prom', 'prometheus', 'Prometheus 1'),
  advanced: template.datasource(
    'newhost',
    'newelastic',
    'newtest-query',
    hide='load',
    regex='prom.*',
    label='foo',
    refresh='time',
  ),
}
