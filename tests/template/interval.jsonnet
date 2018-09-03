local grafana = import 'grafonnet/grafana.libsonnet';
local template = grafana.template;

{
  basic: template.interval('interval', '5m,10m,20m', '5m'),
  auto: template.interval('interval', 'auto,5m,10m,20m', 'auto'),
}
