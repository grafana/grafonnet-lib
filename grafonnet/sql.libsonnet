{
    target(
        rawSql,
        datasource=null,
        refId=null,
        format='time_series',
    ):: {
        [if datasource != null then 'datasource']: datasource,
        [if refId != null then 'refId']: refId,
        format: format,
        rawSql: rawSql,
    },
}
