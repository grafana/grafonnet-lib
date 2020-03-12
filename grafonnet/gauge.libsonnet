{
  new(
    title,
    datasource=null,
    calc='mean',
    description='',
    height=null,
    transparent=null,
    thresholds=[],
    decimals=null,
    max=null,
    min=null,
    unit=null,
    repeat=null,
    repeatDirection=null,
    maxPerRow=null,
  )::
    {
      [if description != '' then 'description']: description,
      [if height != null then 'height']: height,
      [if transparent != null then 'transparent']: transparent,
      [if repeat != null then 'repeat']: repeat,
      [if repeatDirection != null then 'repeatDirection']: repeatDirection,
      [if maxPerRow != null then 'maxPerRow']: maxPerRow,
      title: title,
      type: 'gauge',
      datasource: datasource,
      options: {
        fieldOptions: {
          calcs: [
            calc,
          ],
        defaults: {
        [if decimals != null then 'decimals']: decimals,
        [if max != null then 'max']: max,
        [if min != null then 'min']: min,
        [if unit != null then 'unit']: unit,
        },
        thresholds: thresholds,
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

