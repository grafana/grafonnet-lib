{
  /**
   * Creates a [CloudWatch target](https://grafana.com/docs/grafana/latest/features/datasources/cloudwatch/)
   *
   * @name cloudwatch.target
   *
   * @param region
   * @param namespace
   * @param metric
   * @param datasource (optional)
   * @param statistic (default: `'Average'`)
   * @param alias (optional)
   * @param highResolution (default: `false`)
   * @param period (default: `'1m'`)
   * @param dimensions (optional)

   * @return Panel target
   */

  target(
    region,
    namespace,
    metric,
    datasource=null,
    statistic='Average',
    alias=null,
    highResolution=false,
    period='1m',
    dimensions={}
  ):: {
    region: region,
    namespace: namespace,
    metricName: metric,
    [if datasource != null then 'datasource']: datasource,
    statistics: [statistic],
    [if alias != null then 'alias']: alias,
    highResolution: highResolution,
    period: period,
    dimensions: dimensions,
  },
}
