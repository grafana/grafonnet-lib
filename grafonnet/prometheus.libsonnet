{
    target(
        expr,
        intervalFactor=2,
        legendFormat="",
        datasource=null
    ):: {
        [if datasource != null then "datasource"]: datasource,
        expr: expr,
        format: "time_series",
        intervalFactor: intervalFactor,
        legendFormat: legendFormat,
    },
}
