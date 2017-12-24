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
        format="s",
        interval="10s",
        repeatDirection="v",
        height="42px",
        prefixFontSize="10%",
        postfixFontSize="15%",
        prefix="before",
        postfix="after",
        repeat="interval",
        description="mystat",
        min_span=6,
        decimals=2,
        datasource="prom1",
        span=1,
        transparent=true,
        valueFontSize="50%",
        valueName="current",
        mappingType="range",
        valueMaps=["foo"],
        colors=[
            "rgba(237, 129, 40, 0.89)",
            "#d44a3a",
            "#299c46",
        ],
        colorBackground=true,
        colorValue=true,
        thresholds="1,2",
        rangeMaps=["bar"],
    ),
    value: singlestat.new(
        "vv",
        mappingType="value",
    ),
}
