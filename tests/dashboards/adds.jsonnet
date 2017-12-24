local grafana = import "grafonnet/grafana.libsonnet";
local dashboard = grafana.dashboard;
local row = grafana.row;

[
    dashboard.new("test")
    + dashboard.addTemplate({ test: true })
    + dashboard.addRow(row.new(title="1"))
    + dashboard.addRow(row.new(title="2"))
    + dashboard.addRows([row.new(title="1"), row.new(title="2")])
    + dashboard.addAnnotation("foo")
    + dashboard.addAnnotation("bar")
    + dashboard.addLink("foolinks")
    + dashboard.addLink("barlinks"),
    dashboard.new("test2")
    + dashboard.addPanel(row.new(title="id0"), { x: 14, y: 42, w: 33, h: 26 })
    + dashboard.addPanel(row.new(title="id1"), { x: 24, y: 52, w: 43, h: 36 })
    + dashboard.addPanel(row.new(title="id2"), { x: 34, y: 62, w: 53, h: 36 })
    + dashboard.addPanel(row.new(title="id5"), { x: 44, y: 72, w: 63, h: 46 })
    + dashboard.addPanels([row.new(title="id5") + { x: 41, y: 71, w: 61, h: 41 }]),
]
