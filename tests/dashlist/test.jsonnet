local grafana = import '../../grafonnet/grafana.libsonnet';
local Dashlist = grafana.dashlist;

{
  basic: Dashlist.new(
    'test'
  ),
  advanced: Dashlist.new(
    'test',
    description='description',
    tags=['test0', 'test1'],
    recent=false,
    search=true,
    headings=true,
    limit=5
  ),
}
