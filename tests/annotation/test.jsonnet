local grafana = import "grafonnet/grafana.libsonnet";
local annotation = grafana.annotation;

{
    def: annotation.default,
    basic: annotation.datasource("basicname", "up", "prom"),
    advanced: annotation.datasource(
        "newAdv",
        "advExpr",
        "advDS",
        enable=false,
        hide=true,
        iconColor="rgba(25, 6, 6, 2)",
        tags=["foo"],
        type="rows",
    ),
}
