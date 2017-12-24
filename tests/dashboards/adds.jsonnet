local grafana = import "grafonnet/grafana.libsonnet";
local dashboard = grafana.dashboard;
local row = grafana.row;

[
    dashboard.new("test")
    .addTemplate({ test: true })
    .addRow(row.new(title="1"))
    .addRow(row.new(title="2"))
    .addRows([row.new(title="1"), row.new(title="2")])
    .addAnnotation("foo")
    .addAnnotation("bar")
    .addLink("foolinks")
    .addLink("barlinks"),
    dashboard.new("test2")
    .addPanel(row.new(title="id0"), { x: 14, y: 42, w: 33, h: 26 })
    .addPanel(row.new(title="id1"), { x: 24, y: 52, w: 43, h: 36 })
    .addPanel(row.new(title="id2"), { x: 34, y: 62, w: 53, h: 36 })
    .addPanel(row.new(title="id5"), { x: 44, y: 72, w: 63, h: 46 })
    .addPanels([row.new(title="id5") + { x: 41, y: 71, w: 61, h: 41 }]),
]
