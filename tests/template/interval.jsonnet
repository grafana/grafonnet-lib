local grafana = import 'grafonnet/grafana.libsonnet';
local template = grafana.template;

{
  basic: template.interval('interval', '5m,10m,20m', '5m'),
  auto1: template.interval('interval', 'auto,5m,10m,20m', 'auto'),
  auto2: template.interval('interval', '5m,10m,auto,20m', 'auto'),
  auto3: template.interval('interval', '5m,10m,20m,auto', 'auto'),
}
