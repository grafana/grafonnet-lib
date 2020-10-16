{
  /**
   * Creates a [PostgreSQL target](https://grafana.com/docs/grafana/latest/datasources/postgres/)
   *
   * @name postgresql.target
   *
   * @param datasource (optional) Data source name.
   * @param rawSql The raw query should at minimum have `ORDER BY` time and a filter(`WHERE`) on the returned time range.
   *
   * @return Panel target
   */
  target(
    datasource=null,
    rawSql,
  ):: {
    [if datasource != null then 'datasource']: datasource,
    rawSql: rawSql,
    rawQuery: true,
  },
}
