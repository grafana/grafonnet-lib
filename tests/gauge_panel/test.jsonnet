local grafana = import 'grafonnet/grafana.libsonnet';
local gaugePanel = grafana.gaugePanel;

{
  basic:
    gaugePanel.new('basic')
    .addThreshold({ color: 'blue', value: 0 }),
  advanced:
    gaugePanel.new(
      'advanced',
      transparent=true,
      reducerFunction='sum',
      thresholdsMode='percentage',
    ).addThreshold({ color: 'purple', value: 80 }),
  thresholds:
    gaugePanel.new(
      'thresholds',
      min=10,
      max=95,
    ).addThresholds([
      { color: 'green', value: 0 },
      { color: 'yellow', value: 50 },
      { color: 'red', value: 80 },
    ]),
}
