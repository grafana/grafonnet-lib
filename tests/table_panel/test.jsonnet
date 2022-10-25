local grafana = import 'grafonnet/grafana.libsonnet';
local tablePanel = grafana.tablePanel;
local transformation = grafana.transformation;

{
  basic: tablePanel.new(
    'test'
  ),
  advanced: tablePanel.new(
    'test',
    datasource='$PROMETHEUS',
    description='description',
    transparent=true,
    links=[{ targetBlank: true, title: 'foolink', url: 'https://example.com' }],
  ),
  targets:
    [
      tablePanel.new('with targets')
      .addTarget({ a: 'foo' })
      .addTarget({ b: 'foo' }),
      tablePanel.new('with batch targets')
      .addTargets([{ a: 'foo' }, { b: 'foo' }]),
    ],
  transformations:
    [
      tablePanel.new('with transformations')
      .addTransformation(transformation.new('seriesToColumns', options={
        byField: 'instance',
      }))
      .addTransformation(transformation.new('filterFieldsByName', options={
        include: {
          names: [
            'instance',
          ],
        },
      })),
      tablePanel.new('with batch transformations')
      .addTransformations([
        transformation.new('filterFieldsByName', options={
          include: {
            names: [
              'instance',
              'nodename',
              'Value #D',
              'Value #B',
              'Value #C',
              'Value #E',
              'Value #F',
              'Value #G',
              'Value #H',
              'Value #I',
              'Value #J',
              'Value #K',
              'Value #L',
            ],
          },
        }),
        transformation.new('seriesToColumns', options={
          byField: 'instance',
        }),
      ]),
    ],
  hideColumns: tablePanel.new('test').
    addOverridesForField('Time', tablePanel.overrides.hide(true)).
    addOverridesForField('Space', tablePanel.overrides.hide(true)),
}
