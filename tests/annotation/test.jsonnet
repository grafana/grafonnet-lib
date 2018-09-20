local grafana = import 'grafonnet/grafana.libsonnet';
local annotation = grafana.annotation;

{
  def: annotation.default,
  basic: annotation.datasource('basicname', 'prom'),
  advanced: annotation.datasource(
    'newAdv',
    'advDS',
    expr='advExpr',
    enable=false,
    hide=true,
    iconColor='rgba(25, 6, 6, 2)',
    tags=['foo'],
    type='rows',
    builtIn=1,
  ),
}
