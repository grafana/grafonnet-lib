local grafana = import 'grafonnet/grafana.libsonnet';
local tablePanel = grafana.tablePanel;

{
  basic: tablePanel.new(
    'test',
    span=12
  ),
  advanced: tablePanel.new(
    'test',
    span=12,
    datasource='$PROMETHEUS',
    description='description',
    columns=[
      {
        text: 'Users',
        value: 'Users',
      },
    ],
    styles=[
      {
        alias: 'Users',
        colorMode: 'row',
        colors: ['rgba(245,54,54,0.9)', 'rgba(237,129,40,0.89)', 'rgba(50,172,45,0.97)'],
        pattern: 'Users',
        thresholds: ['0', '50'],
        type: 'number',
        unit: 'none',
      },
    ],
    transform='table',
    transparent=true,
    sort={
      col: 1,
      desc: true,
    },
    time_from='24h',
    time_shift='1h',
    links=[{ targetBlank: true, title: 'foolink', url: 'https://example.com' }],
  ),
  targets:
    [
      tablePanel.new('with targets', span=12)
      .addTarget({ a: 'foo' })
      .addTarget({ b: 'foo' }),
      tablePanel.new('with batch targets', span=12)
      .addTargets([{ a: 'foo' }, { b: 'foo' }]),
    ],
  hideColumns: tablePanel.new(
    'test',
    span=12,
  ).
    hideColumn('Time').
    hideColumn('Space'),
}
