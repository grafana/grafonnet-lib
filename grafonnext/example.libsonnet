local grafonnet = (import './main.libsonnet')('v9.2.3');
local dashboard = grafonnet.dashboard;
local panel = grafonnet.dashboard.panels.panel;

dashboard.new('testDashboard')
+ dashboard.withPanels(
  panel.new('testPanel', 'timeseries')
)
