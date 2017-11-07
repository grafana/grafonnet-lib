local grafana = import "grafonnet/grafana.libsonnet";
local graphPanel = grafana.graphPanel;

{
    basic: graphPanel.new("test"),
    advanced: graphPanel.new(
        "test",
        id=2,
        span=8,
        min_span=9,
        format="ms",
        min=10,
        max=10,
        lines=false,
        points=true,
        bars=true,
        dashes=true,
        stack=true,
        repeat="$device",
    ),
    targets: graphPanel.new("with targets")
             + graphPanel.addTarget("foo")
             + graphPanel.addTarget("foo"),
}
