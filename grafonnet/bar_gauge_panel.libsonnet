{
  /**
   * Create a [bar gauge panel](https://grafana.com/docs/grafana/latest/panels/visualizations/bar-gauge-panel/),
   *
   * @name barGaugePanel.new
   *
   * @param title Panel title.
   * @param description (optional) Panel description.
   * @param datasource (optional) Panel datasource.
   * @param unit (optional) The unit of the data.
   * @param reductionFunc (default: null) Reduction method to display data.
   * @param options_orientation (default: 'auto') Set display orientation of the graph.
   * @param options_displayMode (default: 'lcd') Set display orientation of the graph.
   * @param options_min (default: null) Set minimum field value of the graph.
   * @param options_max (default: null) Set maximum field value of the graph.
   * @param pluginVersion (default: null) Set the version of grafana to match with the graph plugin.
   *
   * @method addTarget(target) Adds a target object.
   * @method addTargets(targets) Adds an array of targets.
   * @method addMapping(mapping) Adds a mapping object.
   * @method addThreshold(threshold) Adds a threshold object.
   */
  new(
    title,
    description=null,
    datasource=null,
    unit=null,
    reductionFunc='mean',
    options_orientation='auto',
    options_displayMode='lcd',
    options_min=1,
    options_max=100,
    pluginVersion=null,
  ):: {
    type: 'bargauge',
    title: title,
    [if description != null then 'description']: description,
    datasource: datasource,
    options: {
      fieldOptions: {
        calcs: [
          reductionFunc,
        ],
        defaults: {
          mappings: [],
          thresholds: [],
          [if options_min != null then 'min']: options_min,
          [if options_max != null then 'max']: options_max,
        },
      },
      [if options_orientation != null then 'orientation']: options_orientation,
      [if options_displayMode != null then 'displayMode']: options_displayMode,
      showUnfilled: true,
    },
    [if pluginVersion != null then 'pluginVersion']: pluginVersion,

    _nextTarget:: 0,
    addTarget(target):: self {
      local nextTarget = super._nextTarget,
      _nextTarget: nextTarget + 1,
      targets+: [target { refId: std.char(std.codepoint('A') + nextTarget) }],
    },

    addTargets(targets):: std.foldl(function(p, t) p.addTarget(t), targets, self),

    _nextMapping:: 0,
    addMapping(mapping):: self {
      local nextMapping = super._nextMapping,
      _nextMapping: nextMapping + 1,
      options+: { fieldOptions+: { defaults+: { mappings+: [mapping { id: nextMapping }] } } },
    },

    _nextThreshold:: 0,
    addThreshold(threshold):: self {
      local nextThreshold = super._nextThreshold,
      _nextThreshold: nextThreshold + 1,
      options+: { fieldOptions+: { defaults+: { thresholds+: [threshold { id: nextThreshold }] } } },
    },
  },
}
