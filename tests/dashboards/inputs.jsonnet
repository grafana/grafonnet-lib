local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;

{
  constant: dashboard.new('constant').addInput(
    name='var',
    label='variable',
    type='constant',
    value='default_value',
  ),
  datasource: dashboard.new('datasource').addInput(
    name='datasource',
    label='InfluxDB',
    type='datasource',
    description='InfluxDB datasource',
    pluginId='influxdb',
    pluginName='InfluxDB',
  ),

}
