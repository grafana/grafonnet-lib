local grafana = import 'grafonnet/grafana.libsonnet';
local transformation = grafana.transformation;

{
  basic: transformation.new(),
  advanced: transformation.new(
    'seriesToColumns', options={
      byField: 'instance',
    }
  ),
}
