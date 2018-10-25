local grafana = import 'grafonnet/grafana.libsonnet';
local cloudwatch = grafana.cloudwatch;

{
  basic: cloudwatch.target(
    'eu-west-1',
    'AWS/ApplicationELB',
    'RequestCountPerTarget'
  ),
  advanced: cloudwatch.target(
    'eu-west-1',
    'AWS/ApplicationELB',
    datasource='CloudWatch',
    metric='RequestCountPerTarget',
    statistic='Sum',
    alias='ELB requests per instance',
    dimensions={
      LoadBalancer: 'app/lb',
      TargetGroup: 'targetgroup/tg',
    },
  ),
}
