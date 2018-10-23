local grafana = import 'grafonnet/grafana.libsonnet';
local alertCondition = grafana.alertCondition;

{
  basic: alertCondition.new(),
  advanced: alertCondition.new(
    evaluatorType='within_range',
    evaluatorParams=[1234, 4321],
    operatorType='or',
    reducerType='diff',
    queryRefId='B',
    queryTimeStart='15m',
    queryTimeEnd='now-1h',
  ),
}
