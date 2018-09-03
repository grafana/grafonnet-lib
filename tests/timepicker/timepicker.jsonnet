local grafana = import 'grafonnet/grafana.libsonnet';
local timepicker = grafana.timepicker;

{
  no_changes: timepicker.new(),
  change_refresh_intervals: timepicker.new(
    refresh_intervals=['4s', '4m'],
  ),
  change_time_options: timepicker.new(
    time_options=['4s', '4m'],
  ),
  change_everything: timepicker.new(
    time_options=['7s', '7h'],
    refresh_intervals=['14s', '14d', '8h'],
  ),
}
