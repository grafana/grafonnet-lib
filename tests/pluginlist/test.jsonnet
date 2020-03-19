local grafana = import '../../grafonnet/grafana.libsonnet';
local Pluginlist = grafana.pluginlist;

{
  basic: Pluginlist.new(
    'test'
  ),
  advanced: Pluginlist.new(
    'test',
    description='description',
    limit=5
  ),
}
