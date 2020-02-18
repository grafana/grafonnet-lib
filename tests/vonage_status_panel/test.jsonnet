local grafana = import 'grafonnet/grafana.libsonnet';
local vonageStatusPanel = grafana.vonageStatusPanel;

{
  basic: vonageStatusPanel.new(
    'test'
  ),
  advanced: vonageStatusPanel.new(
    title='test',
    panelTitle='My panel',
    removePrefix='My',
    maxAlertNumber=5,
    colorMode='Metric',
    colors={
      crit: 'rgba(245, 54, 54, 0.9)',
      disable: '#C4162A',
      ok: 'rgba(50, 128, 45, 0.9)',
      warn: 'rgba(237, 129, 40, 0.9)',
    },
    isGrayOnNoData=true
  ),
  target: vonageStatusPanel.new(
    title='test'
  ).addTarget(
    { alias: 'alias' },
    vonageStatusPanel.display(
      alias='alias',
      handlerType='Number Threshold',
      decimals=3,
      crit=1,
      warn=0.5,
      showAlways=true
    )
  ),
}
