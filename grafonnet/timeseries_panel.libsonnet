{
  /**
   * Creates a [timeseries panel](https://grafana.com/docs/grafana/next/visualizations/time-series/).
   * It requires the time series panel plugin in grafana, which is built-in.
   *
   * @name timeseriesPanel.new
   *
   * @param title The title of the graph panel.
   * @param description (optional) The description of the panel.
   * @param transparent (default `false`) Whether to display the panel without a background.
   * @param unit (optional) The unit to use for values.
   * @param min (optional) The minimum value to display.
   * @param max (optional) The maximum value to display.
   * @param decimals (optional) The number of decimal places to display.
   * @param displayName (optional) Override the series or field name.
   * @param colorMode (default `'palette-classic'`) The color mode to use.
   * @param colorBy (default `'last'`) How to determine the color to use. `'last'`, `'min'`, or `'max'`.
   * @param fixedColor (optional) The color to use when `colorMode` is `'fixed'`.
   * @param noValue (optional) What to show when there is no value.
   * @param thresholdDisplay (default `'off'`) How thresholds should be visualised. `'off'`, `'line'`, `'area'`, or `'line+area'`.
   * @param thresholdMode (default `'absolute'`) Whether thresholds are absolute or a percentage. `'absolute'` or `'percentage'`.
   * @param graphStyle (default `'line'`) The type of graph to draw. `'line'`, `'bars'`, or `'points'`.
   * @param legendMode (default `list`) How to display (or not) the legend. `'list`', `'table'`, or `'hidden`'.
   * @param legendPlacement (default `bottom`) Where to display the legend. `'bottom`' or `'right'`.
   * @param legendValues (default `[]`) A list of values to calculate and display in the legend. Options are: `'lastNotNull'`, `'last'`, `'firstNotNull'`, `'first'`, `'min'`, `'max'`, `'mean'`, `'sum'`, `'count'`, `'range'`, `'delta'`, `'step'`, `'diff'`, `'logmin'`, `'allIsZero'`, `'allIsNull'`, `'changeCount'`, `'distinctCount'`, `'diffperc'`, `'allValues'`, `'uniqueValues'`.
   * @param lineInterpolation (default `'linear'`) The interpolation method to use when `graphStyle` is `'line'`. `'linear'`, '`smooth'`, `'stepBefore'`, or `'stepAfter'`.
   * @param lineStyle (default `solid`) The draw style of the line when `graphStyle` is `'line'`. `'solid'`, `'dash'`, or `'dot'`.
   * @param lineDashSegments When `graphStyle` is `'line'`, an array specifying the length of dashes and gaps when `lineStyle` is `'dash'` or the gaps between dots when `lineStyle` is `'dot'`.
   * @param lineWidth (default `1`) The thickness of the line to draw when `graphStyle` is `'line'` or `'bars'`.
   * @param barAlignment (default `'center'`) How bars should be aligned when `graphStyle` is `'bars'`. `'left'`, `'center'`, or `'right'`.
   * @param connectNullValues (default `false`) When graphStyle` is `'line'`, whether to connect null values or not. Can also specify a number of seconds beyond which points will not be connected. `true`, `false`, `<number of seconds>`.
   * @param fillOpacity (default `0`) The opacity to fill the area beneath the graph when `graphStyle` is `'line'` or `'bars'`.
   * @param showPoints (default `'auto'`) When `graphStyle` is `'line'` or '`bars``, whether to display datapoints on the graph. `'auto'`, `'always'`, or `'never'`.
   * @param pointSize (default `5`) The size of points on the graph.
   * @param stackSeries (default `'none'`) How series should be stacked. `'none'`, `'normal'`, or `'100%'`.
   * @param gradientMode (default `none`) The gradient style to apply to the fill when `graphStyle` is `'line'` or `'bars'`. `'none'`, `'opacity'`, `'hue'`, or `'scheme'`.
   * @param axisPlacement (default `'auto'`) How the axis should be aligned. `'auto'`, `'left'`, `'right'`, or `'hidden'`.
   * @param axisLabel (default `''`) The axis label.
   * @param axisWidth (default `'auto'`) The axis width.
   * @param axisSoftMin (optional) The soft minimum for the axis.
   * @param axisSoftMax (optional) The soft maximum for the axis.
   * @param axisShowGridLines (default `'auto'`) Whether to show grid lines. `'auto'`, `true`, or `false`.
   * @param axisLogBase (optional) If set, scale the axis logarithmically with the given base (valid values `2` or `10`). If not set, the axis will have a linear scale.
   * @param tooltip (default `'single'`) The tooltip mode, `'single'`, `'all'`, or `'hidden'`.
   * @param tooltipSort (default `'none'`) Value sort order when tooltip mode is `'all'`. `'none'`, `'ascending'`, or `'descending'`.
   * @param links (optional) Array of links for the panel.
   * @param repeat (optional) Name of variable that should be used to repeat this panel.
   * @param repeatDirection (default `'h'`) 'h' for horizontal or 'v' for vertical.
   * @param repeatMaxPerRow (optional) How many panels to limit each row to when repeating horizontally.
   * @return A json that represents a graph panel.
   *
   * @method addTarget(target) Adds a target object.
   * @method addTargets(targets) Adds an array of targets.
   * @method addLink(link) Add a link to the panel.
   * @method addLinks(links) Adds an array of links to the panel.
   * @method addThreshold(color, value=null) Adds a threshold.
   * @method addValueMapping(value, color, displayText=null) Adds a value mapping.
   * @method addRangeMapping(from, to, color, displayText=null) Adds a range mapping.
   * @method addRegexMapping(pattern, color, displayText=null) Adds a regular expression mapping.
   * @method addSpecialMapping(match, color, displayText=null) Adds a special mapping.
   * @method addDataLink(url, title='', newWindow=false) Adds a data link.
   * @method addOverridesForField(field, overrides) Add a list of overrides for a named field.
   * @method addOverridesForFieldsMatchingRegex(regex, overrides) Add a list of overrides for field names matching a given regex.
   * @method addOverridesForFieldsOfType(type, overrides) Add a list of overrides for fields of a given type.
   * @method addOverridesForQuery(queryId, overrides) Add a list of overrides for fields from a given query.
   */
  new(
    title,
    description=null,
    transparent=false,
    unit=null,
    min=null,
    max=null,
    decimals=null,
    displayName=null,
    colorMode='palette-classic',
    fixedColor=null,
    colorBy='last',
    noValue=null,
    thresholdDisplay='off',
    thresholdMode='absolute',
    graphStyle='line',
    legendMode='list',
    legendPlacement='bottom',
    legendValues=[],
    lineInterpolation='linear',
    lineStyle='solid',
    lineDashSegments=null,
    lineWidth=1,
    barAlignment='center',
    connectNullValues=false,
    fillOpacity=0,
    showPoints='auto',
    pointSize=5,
    stackSeries='none',
    gradientMode='none',
    axisPlacement='auto',
    axisLabel='',
    axisWidth='auto',
    axisSoftMin=null,
    axisSoftMax=null,
    axisShowGridLines='auto',
    axisLogBase=null,
    tooltip='single',
    tooltipSort=null,
    links=[],
    repeat=null,
    repeatDirection='h',
    repeatMaxPerRow=null,
  ):: {
    type: 'timeseries',
    title: title,
    [if description != null then 'description']: description,
    [if transparent then 'transparent']: transparent,
    fieldConfig: {
      defaults: {
        custom: {
          axisLabel: axisLabel,
          axisPlacement: axisPlacement,
          [if axisWidth != 'auto' then 'axisWidth']: axisWidth,
          [if axisSoftMin != null then 'axisSoftMin']: axisSoftMin,
          [if axisSoftMax != null then 'axisSoftMax']: axisSoftMax,
          [if axisShowGridLines != 'auto' then 'axisGridShow']: axisShowGridLines,
          barAlignment: {
            left: -1,
            center: 0,
            right: 1,
          }[barAlignment],
          drawStyle: graphStyle,
          fillOpacity: fillOpacity,
          gradientMode: gradientMode,
          hideFrom: {
            legend: false,
            tooltip: false,
            viz: false,
          },
          lineInterpolation: lineInterpolation,
          [if graphStyle == 'line' then 'lineStyle']: {
            fill: lineStyle,
            [if lineStyle == 'dash' then 'dash']: if lineDashSegments != null then lineDashSegments else [10, 10],
            [if lineStyle == 'dot' then 'dash']: if lineDashSegments != null then lineDashSegments else [0, 10],
          },
          lineWidth: lineWidth,
          pointSize: pointSize,
          scaleDistribution: {
            type: if axisLogBase == null then 'linear' else 'log',
            [if axisLogBase != null then 'log']: axisLogBase,
          },
          showPoints: showPoints,
          spanNulls: connectNullValues,
          stacking: {
            group: 'A',
            mode: if stackSeries == '100%' then 'percent' else stackSeries,
          },
          thresholdsStyle: {
            mode: thresholdDisplay,
          },
        },
        mappings: [],
        thresholds: {
          mode: thresholdMode,
          steps: [],
        },
        color: {
          mode: colorMode,
          [if colorMode == 'fixed' && fixedColor != null then 'fixedColor']: fixedColor,
          [if colorBy != 'last' then 'seriesBy']: colorBy,
        },
        [if unit != null then 'unit']: unit,
        [if min != null then 'min']: min,
        [if max != null then 'max']: max,
        [if decimals != null then 'decimals']: decimals,
        [if displayName != null then 'displayName']: displayName,
        [if noValue != null then 'noValue']: noValue,
      },
      overrides: [],
    },
    links: links,
    options: {
      legend: {
        calcs: legendValues,
        displayMode: legendMode,
        placement: legendPlacement,
      },
      tooltip: {
        mode: { single: 'single', all: 'multi', hidden: 'none' }[tooltip],
        sort: if tooltip == 'all' && tooltipSort != null
        then { ascending: 'asc', descending: 'desc' }[tooltipSort]
        else 'none',
      },
    },
    [if repeat != null then 'repeat']: repeat,
    [if repeat != null then 'repeatDirection']: repeatDirection,
    [if repeat != null && repeatDirection == 'h' && repeatMaxPerRow != null then 'maxPerRow']: repeatMaxPerRow,
    targets: [],
    _nextTarget:: 0,
    addThreshold(color, value=null):: self {
      fieldConfig+: { defaults+: { thresholds+: { steps+: [{ color: color, value: value }] } } },
    },
    addLink(link):: self {
      links+: [link],
    },
    addLinks(links):: std.foldl(function(p, t) p.addLink(t), links, self),
    addTarget(target):: self {
      // automatically ref id in added targets.
      // https://github.com/kausalco/public/blob/master/klumps/grafana.libsonnet
      local nextTarget = super._nextTarget,
      _nextTarget: nextTarget + 1,
      targets+: [target { refId: std.char(std.codepoint('A') + nextTarget) }],
    },
    addTargets(targets):: std.foldl(function(p, t) p.addTarget(t), targets, self),
    _nextMapping:: 0,
    local addMapping = function(type, options) self {
      local nextMapping = super._nextMapping,
      _nextMapping: nextMapping + 1,
      fieldConfig+: { defaults+: { mappings+: [{ type: type, options: options(nextMapping) }] } },
    },
    addValueMapping(value, color, displayText=null)::
      addMapping(type='value', options=function(index) {
        [value]: {
          color: color,
          index: index,
          [if displayText != null then 'text']: displayText,
        },
      }),
    addRangeMapping(from, to, color, displayText=null)::
      addMapping(type='range', options=function(index) {
        from: from,
        to: to,
        result: {
          color: color,
          index: index,
          [if displayText != null then 'text']: displayText,
        },
      }),
    addRegexMapping(pattern, color, displayText=null)::
      addMapping(type='regex', options=function(index) {
        pattern: pattern,
        result: {
          color: color,
          index: index,
          [if displayText != null then 'text']: displayText,
        },
      }),
    addSpecialMapping(match, color, displayText=null)::
      addMapping(type='special', options=function(index) {
        match: match,
        result: {
          color: color,
          index: index,
          [if displayText != null then 'text']: displayText,
        },
      }),
    addDataLink(url, title='', newWindow=false):: self {
      fieldConfig+: {
        defaults+: {
          links+: [
            {
              title: title,
              url: url,
              [if newWindow == true then 'targetBlank']: true,
            },
          ],
        },
      },
    },
    local addOverrides = function(matcher, overrides) self {
      fieldConfig+: { overrides+: [{ matcher: matcher, properties: overrides }] },
    },
    addOverridesForField(field, overrides)::
      addOverrides(matcher={ id: 'byName', options: field }, overrides=overrides),
    addOverridesForFieldsMatchingRegex(regex, overrides)::
      addOverrides(matcher={ id: 'byRegexp', options: regex }, overrides=overrides),
    addOverridesForFieldsOfType(type, overrides)::
      addOverrides(matcher={ id: 'byType', options: type }, overrides=overrides),
    addOverridesForQuery(queryId, overrides)::
      addOverrides(matcher={ id: 'byFrameRefID', options: queryId }, overrides=overrides),
  },
  /**
   * Helpers for use with the addOverrides* methods of the timeseries panel.
   *
   * Example usage:
   *   grafana.timeseriesPanel.new(title='my panel')
   *     .addOverridesForField(field='somefield', overrides=[overrides.lineWidth(5)])
   */
  overrides:: {
    graphStyle(style):: { id: 'custom.drawStyle', value: style },
    lineInterpolation(type):: { id: 'custom.lineInterpolation', value: type },
    barAlignment(alignment):: { id: 'custom.barAlignment', value: { left: -1, center: 0, right: 1 }[alignment] },
    lineWidth(width):: { id: 'custom.lineWidth', value: width },
    fillOpacity(opacity):: { id: 'custom.fillOpacity', value: opacity },
    gradientMode(mode):: { id: 'custom.gradientMode', value: mode },
    fillBelowTo(series):: { id: 'custom.fillBelowTo', value: series },
    lineStyleSolid():: { id: 'custom.lineStyle', value: { fill: 'solid' } },
    lineStyleDash(segments):: { id: 'custom.lineStyle', value: { fill: 'dash', dash: segments } },
    lineStyleDot(gaps):: { id: 'custom.lineStyle', value: { fill: 'dot', dash: gaps } },
    connectNullValues(setting):: { id: 'custom.spanNulls', value: setting },
    showPoints(setting):: { id: 'custom.showPoints', value: setting },
    pointSize(size):: { id: 'custom.pointSize', value: size },
    stackSeries(mode, group='A'):: { id: 'custom.stacking', value: { mode: mode, group: group } },
    transformSeries(transformation):: { id: 'custom.transform', value: transformation },
    axisPlacement(position):: { id: 'custom.axisPlacement', value: position },
    axisLabel(label):: { id: 'custom.axisLabel', value: label },
    axisWidth(width):: { id: 'custom.axisWidth', value: width },
    axisSoftMin(min):: { id: 'custom.axisSoftMin', value: min },
    axisSoftMax(max):: { id: 'custom.axisSoftMax', value: max },
    axisShowGridLines(setting):: { id: 'custom.axisGridShow', value: setting },
    axisLinear():: { id: 'custom.scaleDistribution', value: { type: 'linear' } },
    axisLog(log):: { id: 'custom.scaleDistribution', value: { type: 'log', log: log } },
    hideSeries(tooltip, viz, legend):: { id: 'custom.hideFrom', value: { tooltip: tooltip, viz: viz, legend: legend } },
    unit(unit):: { id: 'unit', value: unit },
    min(min):: { id: 'min', value: min },
    max(max):: { id: 'max', value: max },
    decimals(places):: { id: 'decimals', value: places },
    displayName(name):: { id: 'displayName', value: name },
    fixedColor(color):: { id: 'color', value: { mode: 'fixed', fixedColor: color } },
    colorScheme(name, colorBy='last'):: { id: 'color', value: { mode: name, seriesBy: colorBy } },
    noValue(value):: { id: 'noValue', value: value },
    dataLinks(links):: { id: 'links', value: links },
    valueMappings(mappings):: { id: 'mappings', value: mappings },
    thresholds(thresholds, type='absolute'):: { id: 'thresholds', value: { mode: type, steps: thresholds } },
    showThresholds(style):: { id: 'custom.thresholdsStyle', value: { mode: style } },
  },
}
