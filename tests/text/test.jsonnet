local grafana = import 'grafonnet/grafana.libsonnet';
local text = grafana.text;

{
  basic: text.new(span=12),
  advanced: text.new(
    title='foo',
    datasource='$PROMETHEUS',
    description='description',
    span=5,
    mode='html',
    content='coocoo',
    transparent=true,
  ),
}
