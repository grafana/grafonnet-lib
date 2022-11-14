local grafana = import 'grafonnet/grafana.libsonnet';
local stat = grafana.statPanel;

{
  basic:
    stat.new('basic'),
  advanced:
    stat.new(
      'advanced',
      description='An advanced stat panel configuration',
      transparent=true,
      reduceValues=false,
      reducerFunction='sum',
      sparkLines=true,
      thresholdDisplay='percentage',
    ),
  links:
    stat.new('links')
    .addLinks([
      { title: 'test link', url: 'https://test', targetBlank: true },
      { title: 'test link 2', url: 'http://test2' },
    ]),
  thresholds:
    stat.new('thresholds')
    .addThreshold('yellow', 0)
    .addThreshold('green', 75)
    .addThreshold('red', 90),
  mappings:
    stat.new('mappings')
    .addValueMapping('100', displayText='10*2')
    .addRangeMapping('0', '99', displayText='Less than 100'),
}
