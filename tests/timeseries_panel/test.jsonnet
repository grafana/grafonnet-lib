local grafana = import 'grafonnet/grafana.libsonnet';
local timeseries = grafana.timeseriesPanel;

{
  defaults:
    timeseries.new('defaults'),
  advanced:
    grafana.timeseriesPanel.new(
      title='advanced',
      description='An advanced timeseries panel configuration',
      transparent=true,
      unit='s',
      min=-10,
      max=10,
      legendMode='table',
      legendPlacement='right',
      legendValues=['min', 'max', 'mean'],
      lineStyle='dash',
      lineDashSegments=[30, 60],
      lineWidth=4,
      gradientMode='hue',
      showPoints='always',
      pointSize=10,
      connectNullValues=true,
      fillOpacity='50',
      stackSeries='normal',
      axisPlacement='right',
      axisLabel='y-axis',
      axisWidth=100,
      axisSoftMin=5,
      axisSoftMax=95,
      axisShowGridLines='true',
      axisLogBase=2,
      tooltip='all',
      tooltipSort='ascending',
      decimals=2,
      displayName='a name',
      colorBy='min',
      noValue='none',
    ),
  thresholds:
    grafana.timeseriesPanel.new(
      title='thresholds',
      description='A panel with threshold markers',
      thresholdDisplay='line',
      thresholdMode='perecentage',
    ).addThreshold({ color: 'yellow', value: 0 })
    .addThreshold({ color: 'green', value: 75 })
    .addThreshold({ color: 'red', value: 90 }),
}
