local grafana = import 'grafonnet/grafana.libsonnet';
local template = grafana.template;

{
  basic: template.constant(
    'project_name',
    'Project',
    'myProject',
    hide='variable'
  ),
}
