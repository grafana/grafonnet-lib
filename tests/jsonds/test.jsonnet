local grafana = import 'grafonnet/grafana.libsonnet';
local jsonds = grafana.jsonds;

{
  datasource: jsonds.target(
   "table", "target_name"
  )
}
