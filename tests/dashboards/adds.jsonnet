local grafana = import "grafonnet/grafana.libsonnet";
local dashboard = grafana.dashboard;

dashboard.new("test")
+ dashboard.addTemplate({ test: true })
