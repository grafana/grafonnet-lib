local grafonnet = (import './main.libsonnet')('latest');
local dashboard = grafonnet.dashboard;
local panel = grafonnet.dashboard.panels.panel;

dashboard.new('testDashboard')
+ dashboard.withPanels(
  panel.new('testPanel', 'timeseries')
)
