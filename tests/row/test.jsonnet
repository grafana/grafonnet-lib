local grafana = import 'grafonnet/grafana.libsonnet';
local row = grafana.row;

{
  basic: row.new(),
  showTite: row.new(title='foo'),
  advanced: row.new(
    title='Test Row',
    height='125px',
    collapse=true,
    repeat='env',
    showTitle=true,
    titleSize='h1'
  ),
  panels: row.new(
    height='250px',
  )
          .addPanel('foo')
          .addPanel('bar'),
}
