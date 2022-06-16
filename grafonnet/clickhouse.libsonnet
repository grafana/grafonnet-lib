{
  /**
   * Creates an clickhouse SQL target.
   *
   * @name clickhouse.target
   *
   * @param database specify the database
   * @param table specify the table  
   * @param query The SQL query
   * @param format (default `'time_series'`)
   */
  target(
    database,
    table,
    query,
    format='time_series',
  ):: {
    database: database,
    dateLoading: false,
    dateTimeColDataType: 'time_bucket',
    datetimeLoading: false,
    extrapolate: true,
    table: table,
    tableLoading: false,
    skip_comments: true,
    refId: 'A',
    round: '0s',
    format: format,
    intervalFactor: 1,
    dateTimeType: 'DATETIME',
    query: query,
  },
}
