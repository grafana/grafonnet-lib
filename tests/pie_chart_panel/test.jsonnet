local grafana = import 'grafonnet/grafana.libsonnet';
local PieChartPanel = grafana.pieChartPanel;

{
  basic: PieChartPanel.new(
    'test',
    span=12,
  ),
  advanced: PieChartPanel.new(
    'test',
    span=12,
    datasource='$PROMETHEUS',
    description='description',
    aliasColors={ '2xx': '#7EB26D', '4xx': '#F2C96D', '5xx': '#BF1B00' },
    pieType='donut',
    repeat='repeat_variable',
    repeatDirection='h',
    maxPerRow=5,
  ),
  targets: PieChartPanel.new('with targets', span=12)
           .addTarget({ a: 'foo' })
           .addTarget({ b: 'foo' }),
}
