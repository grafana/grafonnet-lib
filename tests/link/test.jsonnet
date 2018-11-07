local grafana = import 'grafonnet/grafana.libsonnet';
local link = grafana.link;

{
  basic: link.dashboards('node', ['nodes', 'system']),
  advance: link.dashboards(
    'adv',
    ['advanced'],
    asDropdown=false,
    includeVars=true,
    keepTime=true,
    icon='info',
    url='https://wiki.company.com',
    targetBlank=true,
    type='link',
  ),
}
