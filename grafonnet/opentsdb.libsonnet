{
  /**
   * Creates an [OpenTSDB target](https://grafana.com/docs/grafana/latest/datasources/opentsdb/)
   *
   * @name opentsdb.target
   *
   * @param metric OpenTSDB query metrics
   * @param alias (optional)
   * @param hide (optional)
   * @param datasource (optional) Datasource
   * @param aggregator Aggregation Function(avg, sum, min, max, etc. ...)
   * @param filters (optional) Query filters on tags (Mutually exclusive with tags)
   * @param tags (optional) Literal kvs for tags(Mutually exclusive with filters)
   * @param disableDownsampling (optional, default: `false`) Disable downsampling
   * @param downsampleAggregator Aggregation Function for downsampling
   * @param downsampleInterval (optional) Time interval for downsampling(30s, 1m, 5m, etc. ...)
   * @param downsampleFillPolicy (optional, default: `none`) Fill policy for downsampling
   * @param shouldComputeRate (optional, default `false`) Switch for rate computing
   * @param isCounter (optional, default `false`) Swithc for counter metric
   * @param shouldComputeTopK (optional, default `false`) Switch for computing topk
   * @param topKType `top` or `bottom`
   * @param topKOption TopK aggregation function(avg, sum, min, max, count)
   * @param topKValue Value of `K`
   *
   * @return Panel target
   */

  target(
    metric,
    datasource=null,
    alias=null,
    hide=null,
    aggregator='sum',
    filters=[],
    tags={},
    disableDownsampling=null,
    downsampleAggregator='avg',
    downsampleInterval=null,
    downsampleFillPolicy='none',
    shouldComputeRate=false,
    isCounter=false,
    shouldComputeTopK=false,
    topKType=null,
    topKOption=null,
    topKValue=null,
  ):: {
    metric: metric,
    aggregator: aggregator,
    [if alias != null then 'alias']: alias,
    [if hide != null then 'hide']: hide,
    [if datasource != null then 'datasource']: datasource,
    [if disableDownsampling != null then 'disableDownsampling']: disableDownsampling,
    [if downsampleInterval == null then 'downsampleInterval']: '',
    downsampleAggregator: downsampleAggregator,
    downsampleFillPolicy: downsampleFillPolicy,

    [if tags != null then 'tags']: tags,
    [if filters != null then 'filters']: [{
      filter: f.filter,
      groupBy: f.groupBy,
      tagk: f.tagk,
      type: f.type,
    } for f in filters],

    shouldComputeRate: shouldComputeRate,
    isCounter: isCounter,
    [if shouldComputeTopK then 'shouldComputeTopK']: shouldComputeTopK,
    [if std.objectHas(self, 'shouldComputeTopK') && self.shouldComputeTopK then 'topKType']: [if topKType != null then topKType else 'top'],
    [if std.objectHas(self, 'shouldComputeTopK') && self.shouldComputeTopK then 'topKOption']: [if topKOption != null then topKOption else 'avg'],
    [if std.objectHas(self, 'shouldComputeTopK') && self.shouldComputeTopK then 'topKValue']: [if topKValue != null then topKValue else 10],
  },
}
