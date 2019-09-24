local grafana = import 'grafonnet/grafana.libsonnet';
local PolystatPanel = grafana.polystatPanel;

{
  basic: PolystatPanel.new(
    'test',
    span=12,
  ),
  advanced: PolystatPanel.new(
    'test',
    span=12,
    datasource='$PROMETHEUS',
    description='description',
  ),
  targets: PolystatPanel.new('with targets', span=12)
           .addTarget({ a: 'foo' })
           .addTarget({ b: 'foo' }),
}
