{
  /**
   * Return a bigquery target.
   * Requires doitintl-bigquery-datasource to be explicitly installed on grafana.
   *
   * @name bigquery.target
   *
   * @param datasource which datasource to use for querying
   * @param rawQuery Enable/disable raw query mode
   * @param rawSql Raw bigquery query
   * @param convertToUTC enable/disable convert to UTC flag using true/false
   * @param location where to process bigquery data, example: US
   * @param orderByCol order by time or metric
   * @param orderBySort sort by ASC or DSC
   * @param format format result as time_series or table
   */
  target(
    datasource=null,
    rawQuery=true,
    rawSql=null,
    convertToUTC=false,
    location=null,
    orderByCol='time',
    orderBySort='ASC',
    format='time_series',
    hide=null,
  ):: {
    [if datasource != null then 'datasource']: datasource,
    rawQuery: rawQuery,
    [if rawSql != null then 'rawSql']: rawSql,
    orderByCol: if orderByCol == 'time' then '1' else if orderByCol == 'metric' then '2' else orderByCol,
    orderBySort: if orderBySort == 'ASC' then '1' else if orderBySort == 'DSC' then '2' else orderBySort,
    convertToUTC: convertToUTC,
    [if location != null then 'location']: location,
    format: format,
    [if hide != null then 'hide']: hide,
  },
}
