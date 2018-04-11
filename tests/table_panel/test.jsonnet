local grafana = import 'grafonnet/grafana.libsonnet';
local tablePanel = grafana.tablePanel;

{
    basic: tablePanel.new('test'),
    advanced: tablePanel.new(
        'test',
        datasource='$PROMETHEUS',
        description='description',
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
    ),
    targets: tablePanel.new('with targets')
             .addTarget({ a: 'foo' })
             .addTarget({ b: 'foo' }),
}
