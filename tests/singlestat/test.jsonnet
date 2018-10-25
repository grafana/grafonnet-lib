local grafana = import 'grafonnet/grafana.libsonnet';
local singlestat = grafana.singlestat;

{
  basic: singlestat.new('single', span=12),
  target:
    singlestat.new('targets', span=12)
    .addTarget('target1')
    .addTarget('target2')
    .addTarget('target3')
  ,
  advanced: singlestat.new(
    'adv',
    format='s',
    interval='10s',
    repeatDirection='v',
    height='42px',
    prefixFontSize='10%',
    postfixFontSize='15%',
    prefix='before',
    postfix='after',
    repeat='interval',
    description='mystat',
    min_span=6,
    decimals=2,
    datasource='prom1',
    span=1,
    transparent=true,
    valueFontSize='50%',
    valueName='current',
    mappingType='range',
    valueMaps=['foo'],
    colors=[
      'rgba(237, 129, 40, 0.89)',
      '#d44a3a',
      '#299c46',
    ],
    colorBackground=true,
    colorValue=true,
    thresholds='1,2',
    rangeMaps=['bar'],
    sparklineFillColor='rgba(189, 174, 189, 0.18)',
    sparklineFull=true,
    sparklineLineColor='rgb(193, 185, 31)',
    sparklineShow=true,
    gaugeShow=true,
    gaugeMinValue=10,
    gaugeMaxValue=23,
    gaugeThresholdMarkers=true,
    gaugeThresholdLabels=true,
  ),
  value: singlestat.new(
    'vv',
    span=12,
    mappingType='value',
  ),
}
