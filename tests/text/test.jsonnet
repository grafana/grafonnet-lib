local grafana = import "grafonnet/grafana.libsonnet";
local text = grafana.text;

{
    basic: text.new(),
    advanced: text.new(
        id=1,
        title="foo",
        span=5,
        mode="html",
        content="coocoo",
        transparent=true,
    ),
}
