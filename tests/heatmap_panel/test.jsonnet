local grafana = import 'grafonnet/grafana.libsonnet';
local heatmapPanel = grafana.heatmapPanel;

{

  basic_timeseries: heatmapPanel.new('basic timeseries test'),

  basic_tsbuckets: heatmapPanel.new('basic tsbuckets test', dataFormat='tsbuckets'),

  advanced_timeseries:
    heatmapPanel.new(
      'advanced timeseries test',
      datasource=null,
      description='description',
      cards_cardPadding=2,
      cards_cardRound=200,
      color_cardColor='#0a437c',
      color_colorScale='sqrt',
      color_exponent=0.25,
      color_max=140,
      color_min=1,
      color_mode='opacity',
      dataFormat='timeseries',
      hideZeroBuckets=true,
      legend_show=true,
      minSpan=6,
      span=12,
      repeat='PROMETHEUS_DS',
      repeatDirection='h',
      tooltipDecimals=5,
      tooltip_show=true,
      tooltip_showHistogram=true,
      xAxis_show=true,
      xBucketNumber=10,
      xBucketSize='1h',
      yAxis_decimals=3,
      yAxis_format='none',
      yAxis_logBase=1,
      yAxis_max=100,
      yAxis_min=0,
      yAxis_show=true,
      yAxis_splitFactor=null,
      yBucketBound='lower',
      yBucketNumber=4,
      yBucketSize=5,
      maxDataPoints=50,
    ),

  advanced_tsbuckets:
    heatmapPanel.new(
      'advanced tsbuckets test',
      datasource='default',
      description='description',
      cards_cardPadding=15,
      cards_cardRound=10,
      color_cardColor='#705da0',
      color_colorScale='sqrt',
      color_exponent=0.25,
      color_mode='opacity',
      dataFormat='tsbuckets',
      hideZeroBuckets=true,
      highlightCards=true,
      legend_show=false,
      repeat='PROMETHEUS_DS',
      repeatDirection='v',
      tooltip_show=true,
      tooltip_showHistogram=false,
      xAxis_show=false,
      xBucketNumber=null,
      xBucketSize=null,
      yAxis_decimals=3,
      yAxis_format='short',
      yAxis_logBase=1,
      yAxis_min=0,
      yAxis_max=1000,
      yAxis_splitFactor=null,
      yBucketBound='auto',
      yBucketNumber=1,
      yBucketSize=2,
      maxDataPoints=50,
    ),

  basic_color_opacity:
    heatmapPanel.new(
      'basic color opacity test',
      color_mode='opacity',
      dataFormat='tsbuckets',
    ),

  color_opacity_black_linear:
    heatmapPanel.new(
      'color opacity black linear test',
      color_mode='opacity',
      color_cardColor='#000000',
      color_colorScale='linear',
      dataFormat='tsbuckets',
    ),

  color_spectrum_cubehelix:
    heatmapPanel.new(
      'color spectrum cubehelix test',
      color_mode='spectrum',
      color_min=0,
      color_max=100,
      color_colorScheme='interpolateCubehelixDefault',
      dataFormat='tsbuckets',
    ),

  y_axis:
    heatmapPanel.new(
      'y axis test',
      dataFormat='timeseries',
      yAxis_decimals=3,
      yAxis_format='percentunit',
      yAxis_min=0,
      yAxis_max=150,
    ),


}
