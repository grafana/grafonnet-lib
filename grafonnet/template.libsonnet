{
  /**
   * Returns a new template that can be added to a dashboard.
   * See what's a [template](https://grafana.com/docs/grafana/latest/variables/templates-and-variables/#templates)
   * 
   * @name template.new Instanciate a new template.
   * 
   * @param name Name of variable
   * @param datasource Template [datasource](https://grafana.com/docs/grafana/latest/variables/variable-types/add-data-source-variable/)
   * @param query [Query expression](https://grafana.com/docs/grafana/latest/variables/variable-types/add-query-variable/) for the datasource.
   * @param label (optional) Display name of the variable dropdown. If null, then the dropdown label will be the variable name.
   * @param allValues (optional) Formatting for [multi-value variables](https://grafana.com/docs/grafana/latest/variables/formatting-multi-value-variables/#formatting-multi-value-variables)
   * @param tagValuesQuery (optional, experimental feature) Group values into [selectable tags](https://grafana.com/docs/grafana/latest/variables/variable-value-tags/)
   * @param current
   * @param hide Choose a hide option: '' (default) the variable dropdown displays the variable Name or Label value. 'label' the variable dropdown only displays the selected variable value and a down arrow. Any other value, no variable dropdown is displayed on the dashboard.
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
   * @name template.interval
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
      allValue: allValues,
      current: {
        value: current,
        text: if current in valuelabels then valuelabels[current] else current,
      },
      options: std.map(
        function(i)
          {
            text: if i in valuelabels then valuelabels[i] else i,
            value: i,
          }, std.split(query, ',')
      ),
      hide: $.hide(hide),
      includeAll: includeAll,
      label: label,
      refresh: $.refresh(refresh),
      multi: multi,
      name: name,
      query: query,
      type: 'custom',
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
