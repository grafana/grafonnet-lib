// Replace the datasource="" with your own datasource
// Replace the elasticsearch.target('<query>' -- with your own ES query 

local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local elasticsearch = grafana.elasticsearch;
local template = grafana.template;
local graphPanel = grafana.graphPanel;

local soeSessions =
  graphPanel.new(
    'SOE Session Count',
    span=6,
    min_span=6,
    format='short',
    fill=0,
    min=0,
    decimals=2,
    datasource='NSA-SOE-EKS-SOEServices-All',
    legend_values=true,
    legend_min=true,
    legend_max=true,
    legend_current=true,
    legend_total=false,
    legend_avg=true,
    legend_alignAsTable=false,  
  ) 
  .addTarget(
    elasticsearch.target(
      'serviceName.keyword:soe AND _exists_:e2eRequestId AND channelId:*DOT*',
      '@timestamp',
      id=1,
      metrics=[{
        "id":"2",
        type: 'count',
      }],
      alias='SEO Session Count',
      bucketAggs=[{
        field: "timestamp",
        "id":"3",
        settings: {
          interval: "5m",
          min_doc_count: 0,
          trimEdges: 0
        },
        type: "date_histogram"
      }],
    )
  );

  local soeErrors =
  graphPanel.new(
    'SOE Error Count',
    span=6,
    min_span=6,
    format='short',
    fill=0,
    min=0,
    decimals=2,
    datasource='NSA-SOE-EKS-SOEServices-All',
    legend_values=true,
    legend_min=true,
    legend_max=true,
    legend_current=true,
    legend_total=false,
    legend_avg=true,
    legend_alignAsTable=false,
  ) 
  .addTarget(
    elasticsearch.target(
      'channelId.keyword:*DOT* AND NOT statusCode:200 AND NOT statusCode:302 AND NOT statusCode:206 AND _exists_:statusCode AND serviceName.keyword:soe AND _exists_:e2eRequestId',
      '@timestamp',
      id=2,
      metrics=[{
        "id":"4",
        type: 'count',
      }],
      alias='SEO Error Count',
      bucketAggs=[{
        field: "timestamp",
        "id":"5",
        settings: {
          interval: "5m",
          min_doc_count: 0,
          trimEdges: 0
        },
        type: "date_histogram"
      }],
    )
  );

dashboard.new(
  'SOE - Dashboard as Code',
  editable=true,
  schemaVersion=18,
  time_from='now-1d',
  tags=['generated'],
)
.addPanels(
  [
    soeSessions { gridPos: { h: 9, w: 12, x: 0, y: 0 }, aliasColors: { "SEO Session Count": "blue" }, },
    soeErrors { gridPos: { h: 9, w: 12, x: 13, y: 0 } , aliasColors: { "SEO Error Count": "red" }, },
  ]
)
