{
  new(
    title,
    datasource=null,
    calc='mean',
    description='',
    height=null,
    transparent=null,
    repeat=null,
    repeatDirection=null,
    unit=null
  )::
    {
      [if description != '' then 'description']: description,
      [if height != null then 'height']: height,
      [if transparent != null then 'transparent']: transparent,
      [if repeat != null then 'repeat']: repeat,
      [if repeatDirection != null then 'repeatDirection']: repeatDirection,
      title: title,
      type: 'gauge',
      datasource: datasource,
      options: {
        fieldOptions: {
          calcs: [
            calc,
          ],
          [if unit != null then 'unit']: unit,
        },
      },
      _nextTarget:: 0,
      addTarget(target):: self {
        local nextTarget = super._nextTarget,
        _nextTarget: nextTarget + 1,
        targets+: [target { refId: std.char(std.codepoint('A') + nextTarget) }],
      },
    },

}
