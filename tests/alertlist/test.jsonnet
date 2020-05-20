local grafana = import 'grafonnet/grafana.libsonnet';
local alertlist = grafana.alertlist;

{
  basic: alertlist.new(span=12),
  advanced: alertlist.new(
    title='Alerts List',
    datasource='$PROMETHEUS',
    description='description',
    span=5,
    show='current',
    limit=20,
    sortOrder=2,
    stateFilter=[
      'ok',
      'pending',
    ],
    onlyAlertsOnDashboard=true,
    transparent=true,
  ),
}
