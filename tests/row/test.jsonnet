local grafana = import "grafonnet/grafana.libsonnet";
local row = grafana.row;

{
    basic: row.new(),
    advanced: row.new(
        title="Test Row",
        id=1,
        height="125px",
        collapse=true,
        repeat="env",
        showTitle=true,
        titleSize="h1"
    ),
    panels: row.new()
            + row.addPanel("foo")
            + row.addPanel("bar"),
}
