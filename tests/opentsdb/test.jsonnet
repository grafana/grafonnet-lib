local grafana = import 'grafonnet/grafana.libsonnet';
local opentsdb = grafana.opentsdb;

{
  basic: opentsdb.target('sys.cpu.system'),
  advanced: opentsdb.target(
    'sys.cpu.system',
    aggregator='max',
    alias='$tag_host',
    tags={ host: 'web0*', dc: 'us-west-01' },
  ),
  rate: opentsdb.target(
    'sys.cpu.system.brust',
    aggregator='avg',
    filters=[
      { filter: 'web01|web02', groupBy: true, tagk: 'host', type: 'literal_or' },
      { filter: '^us-west*', groupBy: false, tagk: 'dc', type: 'regexp' },
    ],
    shouldComputeRate=true,
    isCounter=true,
  ),
  topk: opentsdb.target(
    'sys.cpu.system.brust',
    aggregator='avg',
    filters=[
      { filter: 'web01|web02', groupBy: true, tagk: 'host', type: 'literal_or' },
      { filter: '^us-west*', groupBy: false, tagk: 'dc', type: 'regexp' },
    ],
    shouldComputeRate=true,
    isCounter=true,
    shouldComputeTopK=true,
    topKType='top',
    topKOption='sum',
    topKValue=20,
  ),
}
