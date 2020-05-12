local grafana = import 'grafonnet/grafana.libsonnet';
local influxdb = grafana.influxdb;

{
  rawQuery_basic:
    influxdb.target(
      |||
        SELECT mean("my_field")
        FROM my_meas
        WHERE $timeFilter
        GROUP BY time($__interval)
      |||
    ),

  rawQuery_advanced:
    influxdb.target(
      |||
        SELECT non_negative_derivative(mean("bytes_recv"), 1s) *8
        FROM "net" WHERE ("host" =~ /^my_host.tld\.net$/ AND "interface" =~ /^eth0$/)
        AND $timeFilter
        GROUP BY time($__interval), "host" fill(none)
      |||,
      alias='$tag_host',
      datasource='telegraf',
    ),

  tagged_query_basic:
    influxdb.target(
      measurement='ram',
    )
    .where('metric_name', '=', 'ram_usage')
    .selectField('value').addConverter('mean'),

  tagged_query_advanced:
    influxdb.target(
      alias='$tag_host',
      policy='ret_30w',
      measurement='mem',
      fill=0,
      group_tags=['host'],
    )
    .where('host', '=', 'msk')
    .where('instance', '=~', '/storage/')
    .selectField('used_percent').addConverter('percentile', [95]),

  tagged_query_without_group_by_time:
    influxdb.target(
      measurement='ram',
      group_time=null
    ).where('metric_name', '=', 'ram_usage')
    .selectField('value').addConverter('mean'),

  tagged_query_multiple_selections:
    influxdb.target(
      alias='$tag_host',
      policy='ret_30w',
      measurement='mem',
      fill=0,
      group_tags=['instance', 'zone'],
    )
    .where('host', '=', 'msk')
    .selectField('used_percent').addConverter('percentile', [95])
    .selectField('used_bytes').addConverter('mean').addConverter('math', ' / 1000'),
}
