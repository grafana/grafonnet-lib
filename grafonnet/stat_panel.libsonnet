{
  /**
   * Creates a [stat panel](https://grafana.com/docs/grafana/latest/panels/visualizations/stat-panel/).
   *
   * @name statPanel.new
   *
   * @param title The title of the stat panel.
   * @param description (optional) The description of the panel.
   * @param transparent (default `false`) Whether to display the panel without a background.
   * @param datasource (optional) Datasource.
   * @param unit (optional) The unit to use for values.
   * @param min (optional) The minimum value to display.
   * @param max (optional) The maximum value to display.
   * @param decimals (optional) The number of decimal places to display.
   * @param displayName (optional) Override the series or field name.
   * @param colorMode (default `'palette-classic'`) The color mode to use.
   * @param fixedColor (optional) The color to use when `colorMode` is `'fixed'`.
   * @param noValue (optional) What to show when there is no value.
   * @param thresholdDisplay (default `'off'`) How thresholds should be visualised. `'off'`, `'line'`, `'area'`, or `'line+area'`.
   * @param thresholdMode (default `'absolute'`) Whether thresholds are absolute or a percentage. `'absolute'` or `'percentage'`.
   * @param reduceValues (default `true`) Whether to apply a reducer function.
   * @param reducerFunction (default `'lastNotNull'`) The function to use when reducing values to a single statistic. `lastNotNull`, `last`, `firstNotNull`, `first`, `min`, `max`, `mean`, `variance`, `stdDev`, `sum`, `count`, `range`, `delta`, `step`, `diff`, `logmin`, `allIsZero`, `changeCount`, `distinctCount`, `diffperc`, `allValues`, `uniqueValues`.
   * @param valueLimit (optional) When `reduceValues` is `false`, the maximum number of values to display.
   * @param fields (default `''` - all numeric) A regular expression matching the fields to display.
   * @param orientation (default `'auto'`) The layout orientation. `'auto'`, `'horizontal'`, or `'vertical'`.
   * @param textMode (default `'auto'`) Control whether values are presented with names or not. `'auto'`, `'value'`, `'value_and_name'`, `'name'`, `'none'`.
   * @param colorStyle (default `'value'`) How to colorize the panel. `'none'`, `'value'`, `'background'`.
   * @param sparkLines (default `true`) Whether to display sparklines or not.
   * @param textAlign (default `'auto'`) How text should be aligned. `'auto'` or `'center'`.
   * @param titleTextSize (optional) The size of the title text.
   * @param valueTextSize (optional) The size of the value text.
   * @param connectNullValues (default `false`) When graphStyle` is `'line'`, whether to connect null values or not. Can also specify a number of seconds beyond which points will not be connected. `true`, `false`, `<number of seconds>`.
   * @param fillOpacity (default `0`) The opacity to fill the area beneath the graph when `graphStyle` is `'line'` or `'bars'`.
   * @param showPoints (default `'auto'`) When `graphStyle` is `'line'` or '`bars``, whether to display datapoints on the graph. `'auto'`, `'always'`, or `'never'`.
   * @param pointSize (default `5`) The size of points on the graph.
   * @param stackSeries (default `'none'`) How series should be stacked. `'none'`, `'normal'`, or `'100%'`.
   * @param gradientMode (default `none`) The gradient style to apply to the fill when `graphStyle` is `'line'` or `'bars'`. `'none'`, `'opacity'`, `'hue'`, or `'scheme'`.
   * @param links (optional) Array of links for the panel.
   * @param repeat (optional) Name of variable that should be used to repeat this panel.
   * @param repeatDirection (default `'h'`) 'h' for horizontal or 'v' for vertical.
   * @param repeatMaxPerRow (optional) How many panels to limit each row to when repeating horizontally.
   * @return A json that represents a stat panel.
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
    datasource=null,
    transparent=false,
    unit=null,
    min=null,
    max=null,
    decimals=null,
    displayName=null,
    colorMode='palette-classic',
    fixedColor=null,
    noValue=null,
    thresholdDisplay='off',
    thresholdMode='absolute',
    reduceValues=true,
    reducerFunction='lastNotNull',
    valueLimit=null,
    fields='',
    orientation='auto',
    textMode='auto',
    colorStyle='value',
    sparkLines=true,
    textAlign='auto',
    titleTextSize=null,
    valueTextSize=null,
    connectNullValues=false,
    fillOpacity=0,
    showPoints='auto',
    pointSize=5,
    stackSeries='none',
    gradientMode='none',
    links=[],
    repeat=null,
    repeatDirection='h',
    repeatMaxPerRow=null,
  ):: {
    type: 'stat',
    title: title,
    [if description != null then 'description']: description,
    [if transparent then 'transparent']: transparent,
    fieldConfig: {
      defaults: {
        custom: {
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
    datasource: datasource,
    links: links,
    options: {
      reduceOptions: {
        values: !reduceValues,
        calcs: [reducerFunction],
        [if !reduceValues && valueLimit != null then 'limit']: valueLimit,
        fields: fields,
      },
      orientation: orientation,
      textMode: textMode,
      colorMode: colorStyle,
      graphMode: if sparkLines then 'area' else 'none',
      justifyMode: textAlign,
      [if titleTextSize != null || valueTextSize != null then 'text']: {
        [if titleTextSize != null then 'titleSize']: titleTextSize,
        [if valueTextSize != null then 'valueSize']: valueTextSize,
      },
    },
    [if repeat != null then 'repeat']: repeat,
    [if repeat != null then 'repeatDirection']: repeatDirection,
    [if repeat != null && repeatDirection == 'h' && repeatMaxPerRow != null then 'maxPerRow']: repeatMaxPerRow,
    targets: [],
    pluginVersion: '9.2.4',
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
    addValueMapping(value, color=null, displayText=null)::
      addMapping(type='value', options=function(index) {
        [value]: {
          [if color != null then 'color']: color,
          index: index,
          [if displayText != null then 'text']: displayText,
        },
      }),
    addRangeMapping(from, to, color=null, displayText=null)::
      addMapping(type='range', options=function(index) {
        from: from,
        to: to,
        result: {
          [if color != null then 'color']: color,
          index: index,
          [if displayText != null then 'text']: displayText,
        },
      }),
    addRegexMapping(pattern, color=null, displayText=null)::
      addMapping(type='regex', options=function(index) {
        pattern: pattern,
        result: {
          [if color != null then 'color']: color,
          index: index,
          [if displayText != null then 'text']: displayText,
        },
      }),
    addSpecialMapping(match, color=null, displayText=null)::
      addMapping(type='special', options=function(index) {
        match: match,
        result: {
          color: color,
          [if color != null then 'color']: color,
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
    unit(unit):: { id: 'unit', value: unit },
    min(min):: { id: 'min', value: min },
    max(max):: { id: 'max', value: max },
    decimals(places):: { id: 'decimals', value: places },
    displayName(name):: { id: 'displayName', value: name },
    fixedColor(color):: { id: 'color', value: { mode: 'fixed', fixedColor: color } },
    colorScheme(name):: { id: 'color', value: { mode: name } },
    noValue(value):: { id: 'noValue', value: value },
    dataLinks(links):: { id: 'links', value: links },
    valueMappings(mappings):: { id: 'mappings', value: mappings },
    thresholds(thresholds, type='absolute'):: { id: 'thresholds', value: { mode: type, steps: thresholds } },
    showThresholds(style):: { id: 'custom.thresholdsStyle', value: { mode: style } },
  },
}
