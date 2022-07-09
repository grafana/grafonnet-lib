local grafana = import 'grafonnet/grafana.libsonnet';
local bosun = grafana.bosun;

{
  basic: bosun.target('q("sum:haproxy.frontend.scur{host=*,pxname=*,tier=*}", "5m", "")',
                      alias='$tag_host $tag_pxname'),
}
