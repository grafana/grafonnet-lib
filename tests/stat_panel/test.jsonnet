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
      timeFrom='1h',
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
  basic_grafana6:
    stat.new(
      'basic_grafana6',
      pluginVersion='6.7',
    ),
  advanced_grafana6:
    stat.new(
      'advanced_grafana6',
      pluginVersion='6.7',
      description='An advanced stat panel configuration for Grafana 6.7.x',
      transparent=true,
      allValues=true,
      reducerFunction='sum',
      graphMode='area',
      thresholdsMode='percentage',
    ),
  thresholds_grafana6:
    stat.new(
      'thresholds_grafana6',
      pluginVersion='6.7',
    ).addThresholds([
      { color: 'yellow', value: 0 },
      { color: 'green', value: 75 },
      { color: 'red', value: 90 },
    ]),
}
