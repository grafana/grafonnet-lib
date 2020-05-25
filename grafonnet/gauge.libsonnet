{
  /**
   * @name gauge.new
   */
  new(
    title,
    datasource=null,
    calc='mean',
    time_from=null,
    span=null,
    description='',
    height=null,
    transparent=null,
    max=100,
    min=0,
    gauge_title=null,
    unit='percent',
    values=false,
    labels=false,
    markers=true,
    orientation='auto',
    threshold_mode='absolute',
    pluginVersion=null,
  )::
    {
      [if description != '' then 'description']: description,
      [if height != null then 'height']: height,
      [if transparent != null then 'transparent']: transparent,
      [if time_from != null then 'timeFrom']: time_from,
      [if span != null then 'span']: span,
      title: title,
      type: 'gauge',
      [if pluginVersion != null then 'pluginVersion']: pluginVersion,
      datasource: datasource,
      options: {
        fieldOptions: {
          calcs: [
            calc,
          ],
          defaults: {
            mappings: [],
            max: max,
            min: min,
            thresholds: {
              mode: threshold_mode,
              steps: [],
            },
            title: gauge_title,
            unit: unit,
          },
          overrides: [],
          values: values,
        },
        orientation: orientation,
        showThresholdLabels: labels,
        showThresholdMarkers: markers,
      },
      _nextTarget:: 0,
      addTarget(target):: self {
        local nextTarget = super._nextTarget,
        _nextTarget: nextTarget + 1,
        targets+: [target { refId: std.char(std.codepoint('A') + nextTarget) }],
      },
      addThreshold(color, value=null):: self {
        options+: {
          fieldOptions+: {
            defaults+: {
              thresholds+: {
                steps+: [{
                  color: color,
                  value: value,
                }],
              },
            },
          },
        },
      },
    },

}
