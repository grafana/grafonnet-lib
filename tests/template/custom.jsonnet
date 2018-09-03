local grafana = import 'grafonnet/grafana.libsonnet';
local template = grafana.template;

{
  basic: template.custom('host', 'foo,bar', 'bar'),
  advanced: template.custom(
    'foo',
    'new,old',
    'new',
    label='node',
    hide='value',
    valuelabels={ new: 'nouveau', old: 'ancien' },
  ),
}
