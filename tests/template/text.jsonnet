local grafana = import 'grafonnet/grafana.libsonnet';
local template = grafana.template;

{
  basic: template.text('text_box_name', 'Text Box Name'),
}
