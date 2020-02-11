local grafana = import 'grafonnet/grafana.libsonnet';
local influxdb = grafana.influxdb;

{
  rawQuery_basic: influxdb.target(
    |||
      SELECT mean("my_field")
      FROM my_meas
      WHERE $timeFilter
      GROUP BY time($__interval)
    |||
  ),
  rawQuery_advanced: influxdb.target(
    |||
      SELECT non_negative_derivative(mean("bytes_recv"), 1s) *8
      FROM "net" WHERE ("host" =~ /^my_host.tld\.net$/ AND "interface" =~ /^eth0$/)
      AND $timeFilter
      GROUP BY time($__interval), "host" fill(none)
    |||,
    alias='$tag_host',
    datasource='telegraf',
  ),
  tagged_query_basic: influxdb.target(
    measurement='ram',
    where=([influxdb.tag('metric_name', '=', 'ram_usage')]),
  ),
  tagged_query_advanced: influxdb.target(
    alias='$tag_host',
    policy='ret_30w',
    measurement='mem',
    where=[
      influxdb.tag('host', '=', 'msk'),
      influxdb.tag('instance', '=~', '/storage/'),
    ],
    selections=[
      influxdb.selection('used_percent', [influxdb.converter('percentile', [95])]),
    ],
    group_tags=['host'],
    fill=0,
  ),
  tagged_query_without_group_by_time: influxdb.target(
    measurement='ram',
    where=([influxdb.tag('metric_name', '=', 'ram_usage')]),
    group_time=null
  ),
}
