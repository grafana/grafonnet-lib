{
  /**
   * Creates an SQL target.
   *
   * @name sql.target
   *
   * @param rawSql The SQL query
   * @param datasource (optional)
   * @param format (default `'time_series'`)
   */
  target(
    rawSql,
    datasource=null,
    format='time_series',
  ):: {
    [if datasource != null then 'datasource']: datasource,
    format: format,
    rawSql: rawSql,
  },
}
