{
  /**
   * Creates a [table panel](https://grafana.com/docs/grafana/latest/visualizations/table/) that can be added in a row.
   * It requires the table panel plugin in grafana, which is built-in.
   *
   * @name tablePanel.new
   *
   * @param title The title of the table panel.
   * @param description (optional) Description of the panel
   * @param datasource (optional) Datasource
   * @param unit (optional) The unit to use for values
   * @param decimals (optional) The number of decimal places to display
   * @param display_name (optional) Override the series name
   * @param header (default: `true`) Whether to show the table header
   * @param footer (default: `false`) Whether to show the table footer
   * @param footer_calculation (default: `'sum'`) The reducer function / calculation to display in the footer
   * @param footer_field (optional) The field to display in the footer
   * @param pagination (default: `false`) Whether to offer pagination of results
   * @param min_column_width (optional) The minimum width for column auto resizing
   * @param column_width (optional) The column width
   * @param column_align (default: `'auto'`) The column alignment (`'auto'`, `'left'`, `'center'`, or `'right'`)
   * @param column_filter (default: `false`) Enable/disable column filters
   * @param cell_display_mode (default: `'auto'`) How to display cell values (`'auto'`, `'color-text'`, `'color-background'`, `'color-background-solid'`, `'gradient-gauge'`, `'lcd-gauge'`, `'basic'`. `'json-view'`)
   * @param cell_value_inspect (default `'false'`) Enable cell value inspection in a modal window
   * @param no_value (optional) What to show when there is no value
   * @param transparent (default: `false`) Whether to display the panel without a background
   * @param sort_by (optional) The series to sort rows by
   * @param sort_ascending (default: `true`) Whether to sort in ascending or descending order when `sort_by` is set
   * @param links (optional) Array of links for the panel.
   * @param repeat (optional) Name of variable that should be used to repeat this panel.
   * @param repeatDirection (default `'h'`) 'h' for horizontal or 'v' for vertical.
   * @param repeatMaxPerRow (optional) How many panels to limit each row to when repeating horizontally,
   * @param thresholdMode (default `'absolute'`) Whether thresholds are absolute or a percentage. `'absolute'` or `'percentage'`
   * @return A json that represents a table panel
   *
   * @method addThreshold(color, value=null) Adds a threshold.
   * @method addTarget(target) Adds a target object
   * @method addTargets(targets) Adds an array of targets
   * @method addValueMapping(value, color, displayText=null) Adds a value mapping.
   * @method addRangeMapping(from, to, color, displayText=null) Adds a range mapping.
   * @method addRegexMapping(pattern, color, displayText=null) Adds a regular expression mapping.
   * @method addSpecialMapping(match, color, displayText=null) Adds a special mapping.
   * @method addLink(link) Adds a link
   * @method addOverridesForField(field, overrides) Add a list of overrides for a named field.
   * @method addOverridesForFieldsMatchingRegex(regex, overrides) Add a list of overrides for field names matching a given regex.
   * @method addOverridesForFieldsOfType(type, overrides) Add a list of overrides for fields of a given type.
   * @method addOverridesForQuery(queryId, overrides) Add a list of overrides for fields from a given query.
   */
  new(
    title,
    description=null,
    datasource=null,
    unit=null,
    decimals=null,
    display_name=null,
    header=true,
    footer=false,
    footer_calculation='sum',
    footer_field=null,
    pagination=false,
    min_column_width=null,
    column_width=null,
    column_align='auto',
    column_filter=false,
    cell_display_mode='auto',
    cell_value_inspect=false,
    no_value=null,
    transparent=false,
    sort_by=null,
    sort_ascending=true,
    links=[],
    repeat=null,
    repeatDirection='h',
    repeatMaxPerRow=null,
    thresholdMode='absolute',
  ):: {
    type: 'table',
    title: title,
    [if description != null then 'description']: description,
    [if transparent then 'transparent']: transparent,
    fieldConfig: {
      defaults: {
        custom: {
          align: column_align,
          displayMode: cell_display_mode,
          inspect: cell_value_inspect,
          [if min_column_width != null then 'minWidth']: min_column_width,
          [if column_width != null then 'width']: column_width,
          [if column_filter then 'filterable']: column_filter,
        },
        mappings: [],
        thresholds: {
          mode: thresholdMode,
          steps: [],
        },
        color: {
          mode: 'thresholds',
        },
        [if unit != null then 'unit']: unit,
        [if decimals != null then 'decimals']: decimals,
        [if display_name != null then 'displayName']: display_name,
        [if no_value != null then 'noValue']: no_value,
      },
      overrides: [],
    },
    datasource: datasource,
    options: {
      showHeader: header,
      footer: {
        show: footer,
        reducer: [footer_calculation],
        fields: if footer_field != null then [footer_field] else '',
        [if pagination then 'enablePagination']: true,
      },
      [if sort_by != null then 'sortBy']: [{ desc: if sort_ascending then false else true, displayName: sort_by }],
    },
    links: links,
    [if repeat != null then 'repeat']: repeat,
    [if repeat != null then 'repeatDirection']: repeatDirection,
    [if repeat != null && repeatDirection == 'h' && repeatMaxPerRow != null then 'maxPerRow']: repeatMaxPerRow,
    pluginVersion: '9.2.1',
    _nextTarget:: 0,
    addThreshold(color, value=null):: self {
      fieldConfig+: { defaults+: { thresholds+: { steps+: [{ color: color, value: value }] } } },
    },
    addTarget(target):: self {
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
    addLink(link):: self {
      links+: [link],
    },
    addTransformation(transformation):: self {
      transformations+: [transformation],
    },
    addTransformations(transformations):: std.foldl(function(p, t) p.addTransformation(t), transformations, self),
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
   *   grafana.tablePanel.new(title='my panel')
   *     .addOverridesForField(field='somefield', overrides=[overrides.cellValueInspect(true)])
   */
  overrides:: {
    minColumnWidth(width):: { id: 'custom.minWidth', value: width },
    columnWidth(width=null):: { id: 'custom.width', [if width != null then 'value']: width },
    columnAlignment(align):: { id: 'custom.align', value: align },
    cellDisplayMode(mode):: { id: 'custom.displayMode', value: mode },
    cellValueInspect(inspect):: { id: 'custom.inspect', value: inspect },
    columnFilter(filter):: { id: 'custom.filterable', value: filter },
    hide(hide):: { id: 'custom.hidden', value: hide },
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
