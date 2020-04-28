{
  /**
   * Returns a new Statusmap panel.
   * It requires Statusmap plugin in grafana, which can be installed from
   * https://grafana.com/grafana/plugins/flant-statusmap-panel.
   *
   * @param title The title of the status panel.
   * @param datasource Datasource
   * @param description Panel description
   *
   * @param color_mode String
   * @param color_cardColor String
   * @param color_colorScale String Which kind of scale to use for color gradient
   * @param color_exponent Decimal Which exponent to use for color gradient
   * @param color_colorScheme String Which colors to use for visualization
   * @param color_defaultColor String Default color to use
   * @param color_thresholds List of threshold value and associated color to use
   * @param cards_cardMinWidth Integer minimum bucket width
   * @param cards_cardVSpacing Integer Vertical bucket spacing
   * @param cards_cardHSpacing Integer Horizontal bucket spacing
   * @param cards_cardRound Integer round to display bucket
   * @param xAxis_show Boolean Whether or not to show the X axis, default true
   * @param xAxis_labelFormat
   * @param yAxis_show Boolean Whether or not to show the Y axis
   * @param yAxis_minWidth Integer
   * @param yAxis_maxWidth Integer
   * @param tooltip_show Boolean Whether or not to show tooltips
   * @param legend_show Boolean Whether or not to show legend
   * @param data_unitFormat String How to format the data, default is 'timeseries'
   * @param data_decimals Integer How many decimal to display from timeseries values
   * @param nullPointMode String how to consider missing points, default to 'as empty'
   * @param yAxisSort String how to sort Y axis values, default to 'metric'
   * @param highlightCards Boolean Whether or not highlight buckets when mouse come over
   * @param useMax Boolean
   *
   * @return A json that represents a status panel
   */

  new(
    title,
    datasource=null,
    description=null,
    color_mode='spectrum',
    color_cardColor='#b4ff00',
    color_colorScale='sqrt',
    color_exponent=0.5,
    color_colorScheme='interpolateGnYlRd',
    color_defaultColor='#757575',
    color_thresholds=[],
    cards_cardMinWidth=5,
    cards_cardVSpacing=2,
    cards_cardHSpacing=2,
    cards_cardRound=null,
    xAxis_show=true,
    xAxis_labelFormat='%a %m/%d',
    yAxis_show=true,
    yAxis_minWidth=-1,
    yAxis_maxWidth=-1,
    tooltip_show=true,
    legend_show=true,
    data_unitFormat='short',
    data_decimals=null,
    nullPointMode='as empty',
    yAxisSort='metrics',
    highlightCards=true,
    useMax=true,
  ):: {
    title: title,
    type: 'flant-statusmap-panel',
    [if description != null then 'description']: description,
    [if datasource != null then 'datasource']: datasource,
    cards: {
      cardMinWidth: cards_cardMinWidth,
      cardVSpacing: cards_cardVSpacing,
      cardHSpacing: cards_cardHSpacing,
      cardRound: cards_cardRound,
    },
    color: {
      mode: color_mode,
      cardColor: color_cardColor,
      [if color_mode == 'spectrum' then 'colorScheme']: color_colorScheme,
      [if color_mode == 'opacity' then 'colorScale']: color_colorScale,
      [if color_mode == 'opacity' then 'exponent']: color_exponent,
      [if color_mode == 'discrete' then 'defaultColor']: color_defaultColor,
      [if color_mode == 'discrete' then 'thresholds']: color_thresholds,
    },
    legend: {
      show: legend_show,
    },
    data: {
      unitFormat: data_unitFormat,
      [if data_decimals != null then 'decimals']: data_decimals,
    },
    [if cards_cardRound != null then 'cards_cardRound']: cards_cardRound,

    nullPointMode: 'as empty',
    yAxisSort: yAxisSort,
    highlightCards: highlightCards,
    useMax: useMax,

    _nextTarget:: 0,
    addTarget(target):: self {
      local nextTarget = super._nextTarget,
      _nextTarget: nextTarget + 1,
      targets+: [target { refId: std.char(std.codepoint('A') + nextTarget) }],
    },
    addTargets(targets):: std.foldl(function(p, t) p.addTarget(t), targets, self),
  },

}
