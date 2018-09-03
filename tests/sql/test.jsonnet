local grafana = import 'grafonnet/grafana.libsonnet';
local sql = grafana.sql;

{
  basic: sql.target('SELECT now() AS time, 5 AS value'),
  advanced: sql.target(
    'SELECT time, value FROM table',
    datasource='pg_test',
    format='table',
  ),
}
