local grafana = import 'grafonnet/grafana.libsonnet';
local graphPanel = grafana.graphPanel;

{
  basic: graphPanel.new('Basic', span=12),
  advanced: graphPanel.new(
    'Advanced',
    decimals=2,
    datasource='default',
    description='description',
    show_xaxis=false,
    repeatDirection='v',
    span=8,
    height='2011px',
    min_span=9,
    formatY1='kbytes',
    formatY2='ms',
    min=10,
    max=10,
    labelY1='labelY1',
    labelY2='labelY2',
    lines=false,
    fill=2,
    fillGradient=1,
    linewidth=2,
    nullPointMode='nullAsZero',
    points=true,
    bars=true,
    dashes=true,
    stack=true,
    sort='increasing',
    repeat='$device',
    legend_show=false,
    legend_values=true,
    legend_min=true,
    legend_max=true,
    legend_current=true,
    legend_total=true,
    legend_avg=true,
    legend_alignAsTable=true,
    legend_rightSide=true,
    legend_sideWidth=200,
    legend_hideEmpty=true,
    legend_hideZero=true,
    value_type='cumulative',
    thresholds=[{ colorMode: 'critical', fill: true, line: true, op: 'lt', value: 5 }],
    links=[{ targetBlank: true, title: 'foolink', url: 'https://example.com' }],
    logBase1Y=2,
    transparent=true,
    shared_tooltip=false,
    percentage=false,
  ),
  graph_series: graphPanel.new('Graph Series', span=12, x_axis_mode='series',),
  graph_series_custom_value: graphPanel.new('Graph Series Custom Value', span=12, x_axis_mode='series', x_axis_values='current',),
  targets: graphPanel.new('Targets', span=12)
           .addTarget({ a: 'foo' })
           .addTarget({ b: 'foo' }),
  multipleTargets: graphPanel.new('Multiple Targets', span=12)
                   .addTargets([{ a: 'foo' }, { b: 'foo' }]),
  aliasColors: graphPanel.new('Alias Colors', aliasColors={ busy: '#bf1b00', io: '#70dbed', idle: '#7eb26d' }, span=12),
  sortedLegend: graphPanel.new(
    'Sorted Legend',
    span=12,
    legend_values=true,
    legend_min=true,
    legend_max=true,
    legend_current=true,
    legend_alignAsTable=true,
    legend_rightSide=true,
    legend_sort='current',
    legend_sortDesc=true,
  ),
  alerts: graphPanel.new('Alerts', span=12)
          .addAlert('name of alert')
          .addCondition([]),
  alertsWithMultipleConditions: graphPanel.new('Alerts With Multiple Conditions', span=12)
                                .addAlert('name of alert')
                                .addConditions([{ c1: 'params' }, { c2: 'params' }]),
  links: graphPanel.new('with links', span=12)
         .addLink('foolinks')
         .addLink('barlinks'),
  multipleLinks: graphPanel.new('Multiple Links', span=12)
                 .addLinks([
    { title: 'foo', url: 'link' },
    { title: 'bar', url: 'link' },
  ]),
  axis_decimals: graphPanel.new('Axis decimals', decimals=2, decimalsY1=1),
  staircase_line: graphPanel.new('Staircase line', staircase=true),
}
