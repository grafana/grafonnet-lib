local grafana = import 'grafonnet/grafana.libsonnet';
local template = grafana.template;

{
  basic: template.adhoc('adhoc_name', 'prometheus'),
  advanced: template.adhoc(
    'adhoc_name',
    'prometheus',
    label='foo',
    hide='label',
  ),
}
