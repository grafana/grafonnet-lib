local grafana = import 'grafonnet/grafana.libsonnet';
local graphPanel = grafana.graphPanel;

{
    basic: graphPanel.new('test'),
    advanced: graphPanel.new(
        'test',
        decimals=2,
        datasource='$PROMETHEUS',
        description='description',
        show_xaxis=false,
        repeatDirection='v',
        span=8,
        height='2011px',
        min_span=9,
        format='ms',
        min=10,
        max=10,
        lines=false,
        fill=2,
        linewidth=2,
        nullPointMode='nullAsZero',
        points=true,
        bars=true,
        dashes=true,
        stack=true,
        sort='increasing',
        repeat='$device',
        legend_show=false,
        legend_values=true,
        legend_min=true,
        legend_max=true,
        legend_current=true,
        legend_total=true,
        legend_avg=true,
        legend_alignAsTable=true,
        legend_rightSide=true,
        legend_hideEmpty=true,
        legend_hideZero=true,
    ),
    targets: graphPanel.new('with targets')
             .addTarget({ a: 'foo' })
             .addTarget({ b: 'foo' }),
    multipleTargets: graphPanel.new('with array of targets')
                     .addTargets([{ a: 'foo' }, { b: 'foo' }]),
    aliasColors: graphPanel.new('with colors', aliasColors={ busy: '#bf1b00', io: '#70dbed', idle: '#7eb26d' }),
}
