local grafana = import 'grafonnet/grafana.libsonnet';
local dataLink = grafana.dataLink;

{
  basic: dataLink.new('foo', 'www.foo.com'),
  advance: dataLink.new(
    'foo',
    'www.foo.com',
    targetBlank=true,
  ),
}
