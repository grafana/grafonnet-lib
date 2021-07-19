local grafana = import 'grafonnet/grafana.libsonnet';
local template = grafana.template;

{
  basic: template.constant(
    'project_name',
    value='myProject',
    label='Project',
    hide='variable'
  ),
}
