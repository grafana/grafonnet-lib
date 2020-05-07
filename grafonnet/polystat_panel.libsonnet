{
  /**
   * Returns a new Polystat panel.
   * It requires Polystat plugin in grafana, which can be installed from
   * https://grafana.com/grafana/plugins/grafana-polystat-panel
   *
   * @param title The title of the status panel.
   * @param datasource Datasource, default to null to use Grafana default one
   * @param description Panel description
   * @param minSpan Minimum span of the panel when repeated on a template variable
   * @param span Width of the panel
   * @param colors list of Polystat colors
   * @param interval time interval
   * @param maxPerRow How many Panel max in a row when using repeat
   * @param repeat Which field to use to repeat panel (enables repeatDirection)
   * @param repeatDirection repeat panel horizontaly or verticaly
   * @param savedComposites
   * @param savedOverrides
   * @param timeFrom specific time from for Polystat
   * @param timeShift specific time shift for Polystat
   *
   * @param polystatAnimationSpeed When multiple metrics are to be displayed by a composite, this sets the animation speed in milliseconds (500 min, 5000 default)
   * @param polystatColumnAutoSize Automatically size columns, true or false
   * @param polystatColumns Number of columns
   * @param polystatDefaultClickThrough URL to use when none defined by overrides
   * @param polystatDefaultClickThroughNewTab Open URL in new tab, true or false
   * @param polystatDefaultClickThroughSanitize Sanitize URL, true or false
   * @param polystatDisplayLimit Max number of metrics to display (0 for no limit)
   * @param polystatFontAutoScale Automatically adjust font size, true ou false
   * @param polystatFontSize
   * @param polystatFontType
   * @param polystatGlobalDecimals How many decimal to display
   * @param polystatGlobalDisplayMode Which metric to display, all or triggered
   * @param polystatGlobalDisplayTextTriggeredEmpty
   * @param polystatGlobalOperatorName Operator name to be applied to metrics
   * @param polystatGlobalThresholds Evaluates to state if value is greater than or equal to specified threshold.
   * @param polystatGlobalUnitFormat Metrics unit
   * @param polystatGradientEnabled Enable color gradient, true or false
   * @param polystatHexagonSortByDirection How to sort displayed metrics
   * @param polystatHexagonSortByField Which field to use to sort displayed metrics
   * @param polystatMaxMetrics
   * @param polystatPolygonBorderColor Polygon border color
   * @param polystatPolygonBorderSize Polygon border size
   * @param polystatPolygonGlobalFillColor Color to use to fill Polygon
   * @param polystatRadius Which radius to use for gradient
   * @param polystatRadiusAutoSize Automatically adjust radius, true ou false
   * @param polystatRowAutoSize Automatically adjust row size, true or false
   * @param polystatRows Number of rows
   * @param polystatShape Shape to use to display polygons
   * @param polystatTooltipDisplayMode Show tooltips, true or false
   * @param polystatTooltipDisplayTextTriggeredEmpty
   * @param polystatTooltipFontSize Font size for tooltips
   * @param polystatTooltipFontType Font type for tooltips
   * @param polystatTooltipPrimarySortDirection Primary sort direction for tooltips
   * @param polystatTooltipPrimarySortField Field to use for primary sort
   * @param polystatTooltipSecondarySortDirection Secondary sort direction for tooltips
   * @param polystatTooltipSecondarySortField Field to use for secondary sort
   * @param polystatTooltipTimestampEnabled Show tooltips timestamp, true or false
   *
   * @return A json that represents a status panel
   */

  new(
    title,
    datasource=null,
    description=null,
    minSpan=null,
    span=null,
    colors=['#299c46', 'rgba(237, 129, 40, 0.89)', '#d44a3a'],
    interval='',
    maxPerRow=null,
    repeat=null,
    repeatDirection=null,
    savedComposites=[],
    savedOverrides=[],
    timeFrom=null,
    timeShift=null,
    polystatAnimationSpeed=2500,
    polystatColumnAutoSize=true,
    polystatColumns='',
    polystatDefaultClickThrough='',
    polystatDefaultClickThroughNewTab=false,
    polystatDefaultClickThroughSanitize=false,
    polystatDisplayLimit=100,
    polystatFontAutoScale=true,
    polystatFontSize=12,
    polystatFontType='Roboto',
    polystatGlobalDecimals=2,
    polystatGlobalDisplayMode='all',
    polystatGlobalDisplayTextTriggeredEmpty='OK',
    polystatGlobalOperatorName='avg',
    polystatGlobalThresholds=null,
    polystatGlobalUnitFormat='short',
    polystatGradientEnabled=true,
    polystatHexagonSortByDirection=1,
    polystatHexagonSortByField='name',
    polystatMaxMetrics=0,
    polystatPolygonBorderColor='black',
    polystatPolygonBorderSize=2,
    polystatPolygonGlobalFillColor='#0a50a1',
    polystatRadius='',
    polystatRadiusAutoSize=true,
    polystatRowAutoSize=true,
    polystatRows='',
    polystatShape='hexagon_pointed_top',
    polystatTooltipDisplayMode='all',
    polystatTooltipDisplayTextTriggeredEmpty='OK',
    polystatTooltipFontSize=12,
    polystatTooltipFontType='Roboto',
    polystatTooltipPrimarySortDirection=2,
    polystatTooltipPrimarySortField='thresholdLevel',
    polystatTooltipSecondarySortDirection=2,
    polystatTooltipSecondarySortField='value',
    polystatTooltipTimestampEnabled=true,
  ):: {
    title: title,
    type: 'grafana-polystat-panel',
    [if description != null then 'description']: description,
    [if datasource != null then 'datasource']: datasource,
    colors: colors,
    interval: interval,
    [if minSpan != null then 'minSpan']: minSpan,
    [if span != null then 'span']: span,
    [if repeat != null then 'repeat']: repeat,
    [if repeatDirection != null then 'repeatDirection']: repeatDirection,
    [if maxPerRow != null then 'maxPerRow']: maxPerRow,
    savedComposites: savedComposites,
    savedOverrides: savedOverrides,
    timeFrom: timeFrom,
    timeShift: timeShift,

    polystat: {
      animationSpeed: polystatAnimationSpeed,
      columnAutoSize: polystatColumnAutoSize,
      columns: polystatColumns,
      defaultClickThrough: polystatDefaultClickThrough,
      defaultClickThroughNewTab: polystatDefaultClickThroughNewTab,
      defaultClickThroughSanitize: polystatDefaultClickThroughSanitize,
      displayLimit: polystatDisplayLimit,
      fontAutoScale: polystatFontAutoScale,
      fontSize: polystatFontSize,
      fontType: polystatFontType,
      globalDecimals: polystatGlobalDecimals,
      globalDisplayMode: polystatGlobalDisplayMode,
      globalDisplayTextTriggeredEmpty: polystatGlobalDisplayTextTriggeredEmpty,
      globalOperatorName: polystatGlobalOperatorName,
      [if polystatGlobalThresholds != null then 'globalThresholds']: polystatGlobalThresholds,
      globalUnitFormat: polystatGlobalUnitFormat,
      gradientEnabled: polystatGradientEnabled,
      hexagonSortByDirection: polystatHexagonSortByDirection,
      hexagonSortByField: polystatHexagonSortByField,
      maxMetrics: polystatMaxMetrics,
      polygonBorderColor: polystatPolygonBorderColor,
      polygonBorderSize: polystatPolygonBorderSize,
      polygonGlobalFillColor: polystatPolygonGlobalFillColor,
      radius: polystatRadius,
      radiusAutoSize: polystatRadiusAutoSize,
      rowAutoSize: polystatRowAutoSize,
      rows: polystatRows,
      shape: polystatShape,
      tooltipDisplayMode: polystatTooltipDisplayMode,
      tooltipDisplayTextTriggeredEmpty: polystatTooltipDisplayTextTriggeredEmpty,
      tooltipFontSize: polystatTooltipFontSize,
      tooltipFontType: polystatTooltipFontType,
      tooltipPrimarySortDirection: polystatTooltipPrimarySortDirection,
      tooltipPrimarySortField: polystatTooltipPrimarySortField,
      tooltipSecondarySortDirection: polystatTooltipSecondarySortDirection,
      tooltipSecondarySortField: polystatTooltipSecondarySortField,
      tooltipTimestampEnabled: polystatTooltipTimestampEnabled,
    },

    _nextTarget:: 0,
    addTarget(target):: self {
      local nextTarget = super._nextTarget,
      _nextTarget: nextTarget + 1,
      targets+: [target { refId: std.char(std.codepoint('A') + nextTarget) }],
    },
    addTargets(targets):: std.foldl(function(p, t) p.addTarget(t), targets, self),
  },

}
