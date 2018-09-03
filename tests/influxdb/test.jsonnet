local grafana = import 'grafonnet/grafana.libsonnet';
local influxdb = grafana.influxdb;

{
  basic: influxdb.target(
    |||
      SELECT mean("my_field")
      FROM my_meas
      WHERE $timeFilter
      GROUP BY time($__interval)
    |||
  ),
  advanced: influxdb.target(
    |||
      SELECT non_negative_derivative(mean("bytes_recv"), 1s) *8
      FROM "net" WHERE ("host" =~ /^my_host.tld\.net$/ AND "interface" =~ /^eth0$/)
      AND $timeFilter
      GROUP BY time($__interval), "host" fill(none)
    |||,
    alias='$tag_host',
    datasource='telegraf',
  ),
}
