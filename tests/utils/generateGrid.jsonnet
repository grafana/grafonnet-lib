local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local graphPanel = grafana.graphPanel;
local logPanel = grafana.logPanel;
local tablePanel = grafana.tablePanel;
local singlestat = grafana.singlestat;
local pieChartPanel = grafana.pieChartPanel;
local heatmapPanel = grafana.heatmapPanel;
local gaugePanel = grafana.gaugePanel;
local statPanel = grafana.statPanel;
local utils = grafana.utils;

{
  basic: dashboard.new('basic').addPanels(
    utils.generateGrid([
      graphPanel.new('graph 1', gridHeight=8, gridWidth=12),
      graphPanel.new('graph 2', gridHeight=8, gridWidth=12),
    ])
  ),
  advanced: dashboard.new('advanced').addPanels(
    utils.generateGrid([
      graphPanel.new('graph 1', gridHeight=8, gridWidth=12),
      graphPanel.new('graph 2', gridHeight=8, gridWidth=12),
      row.new('row 1'),
      logPanel.new('log panel', gridHeight=4, gridWidth=10),
      pieChartPanel.new('pie chart', gridHeight=4, gridWidth=4),
      gaugePanel.new('gauge', gridHeight=4, gridWidth=5),
      singlestat.new('singlestat', gridHeight=4, gridWidth=5),
      singlestat.new('another singlestat', gridHeight=4, gridWidth=5),
      graphPanel.new('graph 3', gridHeight=4, gridWidth=19),
      row.new('row 2'),
      heatmapPanel.new('heatmap', gridHeight=10, gridWidth=10),
      tablePanel.new('table', gridHeight=10, gridWidth=10),
      row.new('row 3'),
      graphPanel.new('graph 4', gridHeight=6, gridWidth=12),
      statPanel.new('stat', gridHeight=6, gridWidth=6),
    ])
  ),
  repeatExample1: (
    local servers = ['server1', 'server2', 'server3'];
    local server_hw_panels = std.flattenArrays([
      [
        graphPanel.new('memory', gridHeight=4, gridWidth=10).addTarget({ server: server }),
        graphPanel.new('ram', gridHeight=4, gridWidth=10).addTarget({ server: server }),
        gaugePanel.new('cpu', gridHeight=4, gridWidth=4).addTarget({ server: server }),
      ]
      for server in servers
    ]);
    dashboard.new('repeat example 1').addPanels(utils.generateGrid(server_hw_panels))
  ),
  repeatExample2: (
    local servers = ['server1', 'server2', 'server3'];
    local server_health_panels = [
      graphPanel.new('health overview', gridHeight=4, gridWidth=(24 - 5 * std.length(servers))),
    ] + [
      tablePanel.new('server instances', gridHeight=4, gridWidth=5).addTarget({ server: server })
      for server in servers
    ];
    dashboard.new('repeat example 2').addPanels(utils.generateGrid(server_health_panels))
  ),
}
