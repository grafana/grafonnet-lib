{
  /**
   * Creates a [PostgreSQL target](https://grafana.com/docs/grafana/latest/datasources/postgres/)
   *
   * @name postgresql.target
   *
   * @param datasource (optional) Data source name.
   * @param format (default `'time_series'`) Format options: `'table'` or `'time_series'`.
   * @param rawSql The raw query should at minimum have `ORDER BY` time and a filter(`WHERE`) on the returned time range.
   *
   * @return Panel target
   */
  target(
    datasource=null,
    format='time_series',
    rawSql,
  ):: {
    [if datasource != null then 'datasource']: datasource,
    format: format,
    rawSql: rawSql,
    rawQuery: true,
  },
}
