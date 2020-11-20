{
  /**
   * Creates a [Google Cloud Monitoring target](https://grafana.com/docs/grafana/latest/datasources/cloudmonitoring/)
   *
   * @name google_cloud_monitoring.target
   *
   * @param projectName
   * @param aliasBy
   * @param metricKind
   * @param metricType
   * @param alignmentPeriod (default: `'stackdriver-auto'`)
   * @param crossSeriesReducer
   * @param perSeriesAligner
   * @param groupBys (default: `[]`)
   * @param filters (default: `[]`)
   * @param unit
   * @param valueType

   * @return Panel target
   */

  target(
    projectName,
    aliasBy,
    metricKind,
    metricType,
    alignmentPeriod='stackdriver-auto',
    crossSeriesReducer,
    perSeriesAligner,
    groupBys=[],
    filters=[],
    unit,
    valueType,
    view=null,
  ):: {
      queryType: 'metrics',
      metricQuery: {
        aliasBy: aliasBy,
        alignmentPeriod: alignmentPeriod,
        crossSeriesReducer: crossSeriesReducer,
        filters: filters,
        metricKind: metricKind,
        metricType: metricType,
        perSeriesAligner: perSeriesAligner,
        projectName: projectName,
        groupBys: groupBys,
        unit: unit,
        valueType: valueType,
        view: view,
    }
  },
}
