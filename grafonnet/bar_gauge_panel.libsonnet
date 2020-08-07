{
    /**
     * Create a [bar gauge panel](https://grafana.com/docs/grafana/latest/panels/visualizations/bar-gauge-panel/),
     *
     * @name barGaugePanel.new
     *
     * @param title Panel title.
     * @param datasource Panel datasource.
     * @param unit The unit of the data.
     *
     * @method addTarget(target) Adds a target object.
     * @method addTargets(targets) Adds an array of targets.
     */
    new(
      title,
      datasource=null,
      unit=null
    ):: {
        title: title,
        datasource: datasource,
        type: 'bargauge',
        targets: [
        ],
        fieldConfig: {
            defaults: {
                unit: unit,
            }
        },
        _nextTarget:: 0,
        addTarget(target):: self {
        // automatically ref id in added targets.
        // https://github.com/kausalco/public/blob/master/klumps/grafana.libsonnet
        local nextTarget = super._nextTarget,
        _nextTarget: nextTarget + 1,
        targets+: [target { refId: std.char(std.codepoint('A') + nextTarget) }],
        },
        addTargets(targets):: std.foldl(function(p, t) p.addTarget(t), targets, self),
    }
}