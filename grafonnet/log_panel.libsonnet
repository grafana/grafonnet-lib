{
  new(
    title='',
    datasource=null,
    time_from=null,
    time_shift=null,
    showLabels=false,
    showTime=true,
    sortOrder='Descending',
    wrapLogMessage=true,
    span=12,
    height=null,
  ):: {
    [if height != null then 'height']: height,
    span: span,
    datasource: datasource,
    options: {
      showLabels: showLabels,
      showTime: showTime,
      sortOrder: sortOrder,
      wrapLogMessage: wrapLogMessage,
    },
    targets: [
    ],
    _nextTarget:: 0,
    addTarget(target):: self {
      // automatically ref id in added targets.
      // https://github.com/kausalco/public/blob/master/klumps/grafana.libsonnet
      local nextTarget = super._nextTarget,
      _nextTarget: nextTarget + 1,
      targets+: [target { refId: std.char(std.codepoint('A') + nextTarget) }],
    },
    addTargets(targets):: std.foldl(function(p, t) p.addTarget(t), targets, self),
    timeFrom: time_from,
    timeShift: time_shift,
    title: title,
    type: 'logs',
  },
}
