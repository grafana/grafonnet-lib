local grafana = import "grafonnet/grafana.libsonnet";
local dashboard = grafana.dashboard;
local row = grafana.row;

dashboard.new("test")
+ dashboard.addTemplate({ test: true })
+ dashboard.addRow(row.new(title="1"))
+ dashboard.addRow(row.new(title="2"))
+ dashboard.addRows([row.new(title="1"), row.new(title="2")])
+ dashboard.addAnnotation("foo")
+ dashboard.addAnnotation("bar")
+ dashboard.addLink("foolinks")
+ dashboard.addLink("barlinks")
