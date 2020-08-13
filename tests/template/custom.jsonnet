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
  multi: template.custom(
    'foo',
    'new,current,old',
    ['new', 'old'],
    valuelabels={ new: 'nouveau', current: 'attual', old: 'ancien' },
    multi=true,
  ),
  multiIncludeAll: template.custom(
    'foo',
    'new,old',
    'All',
    valuelabels={ new: 'nouveau', old: 'ancien' },
    multi=true,
    includeAll=true,
  ),
}
