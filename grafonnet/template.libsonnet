{
  /**
   * Returns a new template that can be added to a dashboard.
   * See what's a [template](https://grafana.com/docs/grafana/latest/variables/templates-and-variables/#templates).
   *
   * @name template.new
   *
   * @param name Name of variable
   * @param datasource Template [datasource](https://grafana.com/docs/grafana/latest/variables/variable-types/add-data-source-variable/)
   * @param query [Query expression](https://grafana.com/docs/grafana/latest/variables/variable-types/add-query-variable/) for the datasource.
   * @param label (optional) Display name of the variable dropdown. If null, then the dropdown label will be the variable name.
   * @param allValues (optional) Formatting for [multi-value variables](https://grafana.com/docs/grafana/latest/variables/formatting-multi-value-variables/#formatting-multi-value-variables)
   * @param tagValuesQuery (optional, experimental feature) Group values into [selectable tags](https://grafana.com/docs/grafana/latest/variables/variable-value-tags/)
   * @param current
   * @param hide '' (default) the variable dropdown displays the variable Name or Label value. 'label' the variable dropdown only displays the selected variable value and a down arrow. Any other value, no variable dropdown is displayed on the dashboard.
   * @param regex (optional) Regex expression to filter or capture specific parts of the names returned by your data source query. To see examples, refer to [Filter variables with regex](https://grafana.com/docs/grafana/latest/variables/filter-variables-with-regex/).
   * @param refresh 'never' (default): Variables queries are cached and values are not updated. This is fine if the values never change, but problematic if they are dynamic and change a lot. 'load': Queries the data source every time the dashboard loads. This slows down dashboard loading, because the variable query needs to be completed before dashboard can be initialized. 'time': Queries the data source when the dashboard time range changes. Only use this option if your variable options query contains a time range filter or is dependent on the dashboard time range.
   * @param includeAll Whether all value option is available or not. False by default.
   * @param multi Whether multiple values can be selected or not from variable value list. False by default.
   * @param sort 0 (default): Without Sort, 1: Alphabetical (asc), 2: Alphabetical (desc), 3: Numerical (asc), 4: Numerical (desc).
   *
   * @return A [template](https://grafana.com/docs/grafana/latest/variables/templates-and-variables/#templates)
   */
  new(
    name,
    datasource,
    query,
    label=null,
    allValues=null,
    tagValuesQuery='',
    current=null,
    hide='',
    regex='',
    refresh='never',
    includeAll=false,
    multi=false,
    sort=0,
  )::
    {
      allValue: allValues,
      current: $.current(current),
      datasource: datasource,
      includeAll: includeAll,
      hide: $.hide(hide),
      label: label,
      multi: multi,
      name: name,
      options: [],
      query: query,
      refresh: $.refresh(refresh),
      regex: regex,
      sort: sort,
      tagValuesQuery: tagValuesQuery,
      tags: [],
      tagsQuery: '',
      type: 'query',
      useTags: false,
    },
  /**
   * Use an [interval variable](https://grafana.com/docs/grafana/latest/variables/variable-types/add-interval-variable/) to represent time spans such as '1m', '1h', '1d'. You can think of them as a dashboard-wide "group by time" command. Interval variables change how the data is grouped in the visualization. You can also use the Auto Option to return a set number of data points per time span.
   * You can use an interval variable as a parameter to group by time (for InfluxDB), date histogram interval (for Elasticsearch), or as a summarize function parameter (for Graphite).
   *
   * @name template.interval
   *
   * @param name Variable name
   * @param query
   * @param current
   * @param hide '' (default) the variable dropdown displays the variable Name or Label value. 'label' the variable dropdown only displays the selected variable value and a down arrow. Any other value, no variable dropdown is displayed on the dashboard.
   * @param label (optional) Display name of the variable dropdown. If null, then the dropdown label will be the variable name.
   * @param auto_count (default: 300) Valid only if 'auto' is defined in query. Number of times the current time range will be divided to calculate the value, similar to the Max data points query option. For example, if the current visible time range is 30 minutes, then the auto interval groups the data into 30 one-minute increments. The default value is 30 steps.
   * @param auto_min (default: '10s') Valid only if 'auto' is defined in query. The minimum threshold below which the step count intervals will not divide the time. To continue the 30 minute example, if the minimum interval is set to 2m, then Grafana would group the data into 15 two-minute increments.
   *
   * @return A new interval variable for templating.
   */
  interval(
    name,
    query,
    current,
    hide='',
    label=null,
    auto_count=300,
    auto_min='10s',
  )::
    {
      current: $.current(current),
      hide: $.hide(hide),
      label: label,
      name: name,
      query: std.join(',', std.filter($.filterAuto, std.split(query, ','))),
      refresh: 2,
      type: 'interval',
      auto: std.count(std.split(query, ','), 'auto') > 0,
      auto_count: auto_count,
      auto_min: auto_min,
    },
  hide(hide)::
    if hide == '' then 0 else if hide == 'label' then 1 else 2,
  current(current):: {
    [if current != null then 'text']: current,
    [if current != null then 'value']: if current == 'auto' then
      '$__auto_interval'
    else if current == 'all' then
      '$__all'
    else
      current,
  },
  /**
   * @name template.datasource
   */
  datasource(
    name,
    query,
    current,
    hide='',
    label=null,
    regex='',
    refresh='load',
  ):: {
    current: $.current(current),
    hide: $.hide(hide),
    label: label,
    name: name,
    options: [],
    query: query,
    refresh: $.refresh(refresh),
    regex: regex,
    type: 'datasource',
  },
  refresh(refresh):: if refresh == 'never'
  then
    0
  else if refresh == 'load'
  then
    1
  else if refresh == 'time'
  then
    2
  else
    refresh,
  filterAuto(str):: str != 'auto',
  /**
   * @name template.custom
   */
  custom(
    name,
    query,
    current,
    refresh='never',
    label='',
    valuelabels={},
    multi=false,
    allValues=null,
    includeAll=false,
    hide='',
  )::
    {
      // self has dynamic scope, so self may not be myself below.
      // '$' can't be used neither as this object is not top-level object.
      local custom = self,

      allValue: allValues,
      current: {
        // Both 'all' and 'All' are accepted for consistency.
        value: if includeAll && (current == 'All' || current == 'all') then
          if multi then ['$__all'] else '$__all'
        else
          current,
        text: if std.isArray(current) then
          std.join(' + ', std.map(custom.valuelabel, current))
        else
          custom.valuelabel(current),
        [if multi then 'selected']: true,
      },
      options: std.map(self.option, self.query_array(query)),
      hide: $.hide(hide),
      includeAll: includeAll,
      label: label,
      refresh: $.refresh(refresh),
      multi: multi,
      name: name,
      query: query,
      type: 'custom',

      valuelabel(value):: if value in valuelabels then
        valuelabels[value]
      else value,

      option(option):: {
        text: custom.valuelabel(option),
        value: if includeAll && option == 'All' then '$__all' else option,
        [if multi then 'selected']: if multi && std.isArray(current) then
          std.member(current, option)
        else if multi then
          current == option
        else
          null,
      },
      query_array(query):: std.split(
        if includeAll then 'All,' + query else query, ','
      ),
    },
  /**
   * @name template.text
   */
  text(
    name,
    label=''
  )::
    {
      current: {
        selected: false,
        text: '',
        value: '',
      },
      name: name,
      label: label,
      query: '',
      type: 'textbox',
    },
  /**
   * @name template.adhoc
   */
  adhoc(
    name,
    datasource,
    label=null,
    hide='',
  )::
    {
      datasource: datasource,
      hide: $.hide(hide),
      label: label,
      name: name,
      type: 'adhoc',
    },
}
