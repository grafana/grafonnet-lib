local grafana = import 'grafonnet/grafana.libsonnet';
local elastic = grafana.elasticsearch;

{
  // todo basic
  basic: elastic.target('up', timeField="@timestamp"),
  advanced: elastic.target(
       query="metric.source: iostat AND metric.type: blockdev_request_size_KB",
       timeField="metric.begin",
       alias="{{metric.device}}",
       metrics=[
        {
          id: "1",
          field: "metric.value",
          settings: {
            percents: [
              "90",
            ]
          },
          type: "percentiles"
        }
      ],
      bucketAggs=[
      {
        id: "2",
        field: "metric.device",
        type: "terms",
        settings: {
          order: "desc",
          size: "10",
          min_doc_count: 1,
          orderBy: "_term"
        },
      },
      {
        id: "3",
        field: "@timestamp",
        type: "date_histogram",
        settings: {
            interval: "1s",
            min_doc_count: 0,
            trimEdges: 0
        },
      }
      ],
  ),
  // todo heatmap
}
