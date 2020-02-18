{
  /**
   * Returns status panel metric display settings.
   * It is required to handle target result in status panel visualization
   *
   * @param alias Alias
   * @param aggregation Multiple data points aggregation (Last, Mean, etc)
   * @param valueRegex The regex which will decide the part of the value to be displayed
   * @param url Clickable metric URL
   *
   * @param handlerType Handler type (available handlers: Number Threshold, String Threshold, Date Threshold, Disable Criteria, Text Only)
   * @param displayType Display type (available types: Regular or Annotation)
   * @param units Units of measure (Number Threshold only)
   * @param decimals Decimals precision for numbers (Number Threshold only)
   * @param dateFormat Date/Time format (Date Threshold only)
   *
   * @param crit Critical threshold value. Get numbers, strings or dates (Threshold handlers only)
   * @param warn Warning threshold value. Get numbers, strings or dates (Threshold handlers only)
   * @param showAlways Show the metric also if threshold is not satisfied (Threshold handlers only)
   * @param disabledValue The exact value which will make panel to be displayed as disabled (Disable Criteria only)
   *
   * @return A json that represents a metric display part of status panel target
   */
  display(
    alias=null,
    aggregation='Last',
    valueRegex='',
    url=null,

    handlerType='Number Threshold',
    displayType='Regular',
    units='none',
    decimals=2,
    dateFormat='YYYY-MM-DD HH:mm:ss',

    crit=null,
    warn=null,
    showAlways=false,
    disabledValue=null,
  ):: {
    [if alias != null then 'alias']: alias,
    aggregation: aggregation,
    [if valueRegex != '' then 'valueDisplayRegex']: valueRegex,
    [if url != null then 'url']: url,
    valueHandler: handlerType,
    displayType: displayType,
    [if crit != null then 'crit']: crit,
    [if warn != null then 'warn']: warn,
    display: showAlways,
    units: units,
    decimals: decimals,
    dateFormat: dateFormat,
    [if disabledValue != null then 'disabledValue']: disabledValue,
  },

  /**
   * Returns a new status panel.
   * It requires Status Panel plugin in grafana, which can be installed from
   * https://grafana.com/grafana/plugins/vonage-status-panel.
   *
   * @param title The title of the status panel.
   * @param span Width of the panel
   * @param datasource Datasource
   * @param description Panel description
   * @param transparent Boolean (default: false) If set to true the panel will be transparent
   *
   * @param panelTitle Panel title
   * @param removePrefix A prefix to remove from the name
   * @param maxAlertNumber Max alert number to show in the panel
   *
   * @param flipCard Flip card on/off (true or false)
   * @param flipTime Flip interval
   *
   * @param colorMode Threshold coloring mode (available modes: Panel, Metric, Disabled)
   * @param colors Dictionary with "ok", "warn", "crit", "disable" keys and corresponding panel colors
   *
   * @param isGrayOnNoData Use 'Disable' color if no data
   * @param isIgnoreOKColors Ignore color in OK state
   * @param isHideAlertsOnDisable Hide alerts in Disabled state
   *
   * @return A json that represents a status panel
   */
  new(
    title,
    span=null,
    datasource=null,
    description='',
    transparent=null,

    panelTitle=null,
    removePrefix='',
    maxAlertNumber=null,

    flipCard=false,
    flipTime=5,

    colorMode='Panel',
    colors={
      crit: 'rgba(245, 54, 54, 0.9)',
      disable: 'rgba(128, 128, 128, 0.9)',
      ok: 'rgba(50, 128, 45, 0.9)',
      warn: 'rgba(237, 129, 40, 0.9)',
    },

    isGrayOnNoData=false,
    isIgnoreOKColors=false,
    isHideAlertsOnDisable=false,
  ):: {
    title: title,
    type: 'vonage-status-panel',
    [if span != null then 'span']: span,
    [if datasource != null then 'datasource']: datasource,
    [if description != null then 'description']: description,
    [if transparent != null then 'transparent']: transparent,
    [if panelTitle != null then 'clusterName']: panelTitle,
    [if removePrefix != '' then 'namePrefix']: removePrefix,
    [if maxAlertNumber != null then 'maxAlertNumber']: maxAlertNumber,
    flipCard: flipCard,
    flipTime: flipTime,
    colorMode: colorMode,
    colors: colors,
    isGrayOnNoData: isGrayOnNoData,
    isIgnoreOKColors: isIgnoreOKColors,
    isHideAlertsOnDisable: isHideAlertsOnDisable,
    _nextTarget:: 0,
    addTarget(target, display={}):: self {
      local nextTarget = super._nextTarget,
      _nextTarget: nextTarget + 1,
      targets+: [target { refId: std.char(std.codepoint('A') + nextTarget) } + display],
    },
  },
}
