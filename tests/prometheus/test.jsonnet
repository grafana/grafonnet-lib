local grafana = import "grafonnet/grafana.libsonnet";
local prometheus = grafana.prometheus;

{
    basic: prometheus.target("up"),
    advanced: prometheus.target(
        "apache_up",
        datasource="prom1",
        intervalFactor=1,
        legendFormat="{{instance}}"
    ),
}
