local grafana = import "grafonnet/grafana.libsonnet";
local singlestat = grafana.singlestat;

{
    basic: singlestat.new("single"),
    target:
        singlestat.new("targets")
        + singlestat.addTarget("target1")
        + singlestat.addTarget("target2")
        + singlestat.addTarget("target3")
    ,
    advanced: singlestat.new(
        "adv",
        id=1,
        format="s",
        interval="10s",
        datasource="prom1",
        span=1,
        valueFontSize="50%",
        valueName="current",
    ),
}
