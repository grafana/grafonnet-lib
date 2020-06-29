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
      allValues=true,
      reducerFunction='sum',
      graphMode='area',
      thresholdsMode='percentage',
    ),
  links:
    stat.new('links')
    .addLinks([
      { title: 'test link', url: 'https://test', targetBlank: true },
      { title: 'test link 2', url: 'http://test2' },
    ]),
  thresholds:
    stat.new('thresholds')
    .addThresholds([
      { color: 'yellow', value: 0 },
      { color: 'green', value: 75 },
      { color: 'red', value: 90 },
    ]),
  mappings:
    stat.new('mappings')
    .addMappings([
      {
        type: 1,
        text: '10*2',
        value: '100',
      },
      {
        type: 2,
        from: '0',
        to: '99',
        text: 'Less than 100',
      },
    ]),
}
